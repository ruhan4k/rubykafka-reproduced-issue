$kafka = Kafka.new(["kafka:9092"], client_id: "debug-app")
$kafka_producer = $kafka.async_producer(
  # Commented so that we can use manual delivery!
  #delivery_threshold: 20,
  #delivery_interval: 4
)
