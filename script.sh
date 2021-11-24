# Java installation
eval "mkdir presto-test"
eval "cd presto-test"
eval "mkdir java-install"
eval "cd java-install"
eval "wget https://download.java.net/java/GA/jdk11/9/GPL/openjdk-11.0.2_linux-x64_bin.tar.gz"
eval "tar zxvf openjdk-11.0.2_linux-x64_bin.tar.gz"
eval "rm openjdk-11.0.2_linux-x64_bin.tar.gz"
eval "export JAVA_HOME=~/presto-test/java-install/jdk-11.0.2"
eval "export PATH=$JAVA_HOME/bin:$PATH"



# Presto server installation and config
eval "wget https://repo1.maven.org/maven2/com/facebook/presto/presto-server/0.264.1/presto-server-0.264.1.tar.gz"
eval "tar -xvzf presto-server-0.264.1.tar.gz && mv presto-server-0.264.1 presto-server"
eval "mkdir data"
eval "cp -r ../../etc/ ./presto-server"

# Presto CLI
eval "wget -O presto https://repo1.maven.org/maven2/com/facebook/presto/presto-cli/0.264.1/presto-cli-0.264.1-executable.jar"
eval "chmod +x presto"

# Kafka
eval "wget -O kafka.tgz https://dlcdn.apache.org/kafka/3.0.0/kafka_2.13-3.0.0.tgz"
eval "tar -xzf kafka.tgz && mv kafka_2.13-3.0.0 kafka-server"
eval "./kafka-server/bin/zookeeper-server-start.sh ./kafka-server/config/zookeeper.properties &"
eval "./kafka-server/bin/kafka-server-start.sh ./kafka-server/config/server.properties &"

eval "wget -O kafka-tpch https://repo1.maven.org/maven2/de/softwareforge/kafka_tpch_0811/1.0/kafka_tpch_0811-1.0.sh"
eval "chmod +x kafka-tpch"
eval "./kafka-tpch load --brokers localhost:9092 --prefix tpch. --tpch-type tiny"

eval "presto-server/bin/launcher start"

# Benchmark driver
eval "cp -r ../../presto-benchmark/ ."
eval "cd presto-benchmark"
eval "wget -O presto-benchmark-driver https://repo1.maven.org/maven2/com/facebook/presto/presto-benchmark-driver/0.265.1/presto-benchmark-driver-0.265.1-executable.jar"
eval "chmod +x presto-benchmark-driver"
eval "./presto-benchmark-driver --server localhost:8080 --debug --warm 10 --catalog kafka"

#eval "./presto --catalog kafka --schema tpch"
