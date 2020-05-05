MSG:= $(shell cat ${TEST_MSG_FILE})

.PHONY: up start stop create_test_topic list_topics describe_test_topic producer_interactive_start consumer_test_topic_start send_test_message

up:
	docker-compose up

start: up create_test_topic

stop:
	docker-compose down

create_test_topic:
	docker-compose exec kafka1 kafka-topics --create --topic ${KAFKA_TOPIC} --partitions 1 --replication-factor 1 --if-not-exists --zookeeper zoo1:2181

list_topics:
	docker-compose exec kafka1 kafka-topics --list --zookeeper zoo1:2181

describe_test_topic:
	docker-compose exec kafka1 kafka-topics --describe --zookeeper zoo1:2181 --topic ${KAFKA_TOPIC}

producer_interactive_start:
	docker-compose exec kafka1 kafka-console-producer --bootstrap-server kafka1:9092 --topic ${KAFKA_TOPIC}

consumer_test_topic_start:
	docker-compose exec kafka1 kafka-console-consumer --bootstrap-server kafka1:9092 --topic ${KAFKA_TOPIC} --from-beginning

send_test_message:
	docker-compose exec kafka1 bash -c 'echo ${MSG} | kafka-console-producer --request-required-acks 1 --broker-list kafka1:9092 --topic ${KAFKA_TOPIC} && echo "Message sent"'
