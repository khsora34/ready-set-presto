# Presto launch with downloaded files

eval "cd presto-test"

# Kafka
eval "./kafka-server/bin/zookeeper-server-start.sh kafka-server/config/zookeeper.properties &"
eval "./kafka-server/bin/kafka-server-start.sh kafka-server/config/server.properties &"
eval "./kafka-tpch load --brokers localhost:9092 --prefix tpch. --tpch-type tiny"
eval "presto-server/bin/launcher start"
eval "./presto --catalog kafka --schema tpch"
