# Presto server installation and config

eval "mkdir presto-test"
eval "cd presto-test"
eval "wget https://repo1.maven.org/maven2/com/facebook/presto/presto-server/0.264.1/presto-server-0.264.1.tar.gz"
eval "tar -xvzf presto-server-0.264.1.tar.gz && mv presto-server-0.264.1 presto-server"
eval "mkdir data"
eval "cd presto-server"
eval "mkdir etc"
eval "cd etc"

eval "echo \"coordinator=true
node-scheduler.include-coordinator=true
http-server.http.port=8080
query.max-memory=5GB
query.max-memory-per-node=1GB
query.max-total-memory-per-node=2GB
discovery-server.enabled=true
discovery.uri=http://localhost:8080\" > config.properties"

eval "echo \"-server
-Xmx16G
-XX:+UseG1GC
-XX:G1HeapRegionSize=32M
-XX:+UseGCOverheadLimit
-XX:+ExplicitGCInvokesConcurrent
-XX:+HeapDumpOnOutOfMemoryError
-XX:+ExitOnOutOfMemoryError
-Djdk.attach.allowAttachSelf=true\" > jvm.config"

eval "echo \"node.environment=test
node.id=ffffffff-ffff-ffff-ffff-ffffffffffff
node.data-dir=../data\" > node.properties"

eval "mkdir catalog"
eval "echo \"connector.name=kafka
kafka.nodes=localhost:9092
kafka.table-names=tpch.customer,tpch.orders,tpch.lineitem,tpch.part,tpch.partsupp,tpch.supplier,tpch.nation,tpch.region
kafka.hide-internal-columns=false\" > catalog/kafka.properties"

eval "cd ../.."

# Presto CLI
eval "wget -O presto https://repo1.maven.org/maven2/com/facebook/presto/presto-cli/0.264.1/presto-cli-0.264.1-executable.jar"
eval "chmod +x presto"


# Kafka
eval "wget -O kafka.tgz https://dlcdn.apache.org/kafka/3.0.0/kafka_2.13-3.0.0.tgz"
eval "tar -xzf kafka.tgz && mv kafka_2.13-3.0.0 kafka-server"
eval "./kafka-server/bin/zookeeper-server-start.sh kafka-server/config/zookeeper.properties &"
eval "./kafka-server/bin/kafka-server-start.sh kafka-server/config/server.properties &"

eval "wget -O kafka-tpch https://repo1.maven.org/maven2/de/softwareforge/kafka_tpch_0811/1.0/kafka_tpch_0811-1.0.sh"
eval "chmod +x kafka-tpch"
eval "./kafka-tpch load --brokers localhost:9092 --prefix tpch. --tpch-type tiny"


eval "presto-server/bin/launcher start"

eval "./presto --catalog kafka --schema tpch"
