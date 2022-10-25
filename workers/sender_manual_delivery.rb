class Sender
  TOPIC = "cats-data"
  # The 1MB maximum that the topic accepts
  TOPIC_MAX_SIZE = 1000 * 1000

  def initialize()
    @current_kafka_message_size = 0
    @number_of_messages_accumulated = 0
    @manual_delivery_threshold = 20
  end

  def perform(iteration = nil)
    payload = data.merge(iteration: iteration).to_json

    # We store the size in bytes of the message as well as
    # how many messages we've accumulated
    @number_of_messages_accumulated += 1
    @current_kafka_message_size += payload.bytesize
    
    batch_greater_than_kafka_topic_size = @current_kafka_message_size > TOPIC_MAX_SIZE
    batch_greater_than_delivery_threshold = @number_of_messages_accumulated == @manual_delivery_threshold

    # If one of the two happens:
    # 1) Messages in the batch will surpass the topic size if a new one enters in the batch
    # 2) Number of messages greater than what we defined as our delivery_threshold
    # We send the messages to kafka!
    if batch_greater_than_kafka_topic_size || batch_greater_than_delivery_threshold
      $kafka_producer.deliver_messages()
      @current_kafka_message_size = payload.bytesize
      @number_of_messages_accumulated = 1
      puts("Batch marked to deliver!")
    end

    $kafka_producer.produce(payload, topic: TOPIC)
  end

  private

  def data
    @data ||= {
      payload: File.read("base64_cat")
    }
  end
end
