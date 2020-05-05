.PHONY: all clean setup test run

all: clean setup test

clean:
	echo clean
setup:
	echo setup

test:
	echo test
run:
	kafka/bin/zookeeper-server-start.sh kafka/config/zookeeper.properties &
	echo sleep 10s
	sleep 10
	kafka/bin/kafka-server-start.sh kafka/config/server.properties &

run_extra:
	kafka/bin/kafka-server-start.sh kafka/config/server-1.properties &
	kafka/bin/kafka-server-start.sh kafka/config/server-2.properties &


stop:
	kafka/bin/kafka-server-stop.sh kafka/config/server.properties &
	echo sleep 10s
	sleep 10
	kafka/bin/zookeeper-server-stop.sh kafka/config/zookeeper.properties & 

create_test_topic:
	kafka/bin/kafka-topics.sh --create --bootstrap-server localhost:9092 --replication-factor 1 --partitions 1 --topic test

create_repl_topic:
	kafka/bin/kafka-topics.sh --create --bootstrap-server localhost:9092 --replication-factor 3 --partitions 1 --topic my-replicated-topic


list_topics:
	kafka/bin/kafka-topics.sh --list --bootstrap-server localhost:9092

describe_test_topic:
	kafka/bin/kafka-topics.sh --describe --bootstrap-server localhost:9092 --topic test


describe_repl_topic:
	kafka/bin/kafka-topics.sh --describe --bootstrap-server localhost:9092 --topic my-replicated-topic


producer_test_start:
	kafka/bin/kafka-console-producer.sh --bootstrap-server localhost:9092 --topic test

consumer_test_start:
	kafka/bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic test --from-beginning

producer_repl_start:
	kafka/bin/kafka-console-producer.sh --bootstrap-server localhost:9092 --topic my-replicated-topi

consumer_repl_start:
	kafka/bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic my-replicated-topi --from-beginning
