## Introduction

This is based on [rubykafka-reproduced-issue](https://github.com/kamilsdz/rubykafka-reproduced-issue) repo but with a new solution for that.

As we can't change the size of the Kafka topic message, I came up with a different solution:

_Instead of using automatic message delivery, we can use a manual message delivery definition and solve the problem in that way!_

I then create two modes of execution that will who you how that can improve the deliveriness of messages:

1. automatic_delivery
2. manual_delivery

The main thing about `manual_delivery` is that it doesn't use `delivery_interval` and `delivery_threshould` parameters, otherwise, it controls the batches by itself. All the details about how simply it can be implemented can be seen [here](https://github.com/ruhan4k/rubykafka-reproduced-issue/blob/master/workers/sender_manual_delivery.rb#L1-L44).

## How to run:

First run `docker-compose up`

Then you will be able to execute the two modes I implemented here.

Run: `docker-compose run app bash`

When you are inside the bash, you can run both modes:

`./run_automatic_delivery`

And

`./run_manual_delivery`

When running the `automatic` one, after about 45 seconds the error will be generated, while the `manual` one can run forever with no errors. :tada:

## References

Read more [here](https://www.waveinit.com/Ruby-Kafka-Buffer-Overflow-Issue/)
