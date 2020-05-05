# kafka-dev

A simple dev environment for working with a single node Apache Kafka cluster.

## Usage
You can use make to:
- set up and run your single node cluster
    ```bash
    make up
    ```
- set up and run your single node cluster and also create your test topic
    ```bash
    make start
    ```
- set up a topic
    ```bash
    make create_test_topic
    ```
- list topics
    ```bash
    make list_topics
    ```
- describe a topic
    ```bash
    make describe_test_topic
    ```
- push a test message from a file to a topic
    ```bash
    make send_test_message
    ```
- interactively push messages to a topic
    ```bash
    make producer_interactive_start
    ```
- consume a topic
    ```bash
    make consumer_test_topic_start
    ```

Topics are specified based upon the `$KAFKA_TOPIC` environment variable.

The message contents are from a file specified by the `$TEST_MSG_FILE` environment variable.

### Logs
Logs go to the console out of the `make up` or `make start` shells.

### Acknowledgments
In the spirit of Prof. Lobachevsky, much of this is taken from:
- https://kafka.apache.org/quickstart
- https://github.com/simplesteph/kafka-stack-docker-compose

