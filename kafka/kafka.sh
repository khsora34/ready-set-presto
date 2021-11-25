# eval "wget -O kafka.tgz https://dlcdn.apache.org/kafka/3.0.0/kafka_2.13-3.0.0.tgz"
eval "tar -xzf kafka.tgz && mv kafka_2.13-3.0.0 kafka-server"

eval "cp kafka/server.properties kafka-server/config/server.properties"
eval "echo 'broker.id=$1' >> kafka-server/config/server.properties"
eval "echo 'advertised.host.name=$2'"

eval "echo -n '$1' > /mnt/nvme/pperezodriguez/myid"

eval "cp kafka/zookeeper.properties kafka-server/config/zookeeper.properties"

eval "./kafka-server/bin/zookeeper-server-start.sh ./kafka-server/config/zookeeper.properties &"
eval "./kafka-server/bin/kafka-server-start.sh ./kafka-server/config/server.properties &"

if (($1 == 1))
then
    #eval "wget -O kafka-tpch https://repo1.maven.org/maven2/de/softwareforge/kafka_tpch_0811/1.0/kafka_tpch_0811-1.0.sh"
    eval "chmod +x kafka-tpch"
    eval "./kafka-tpch load --brokers ares-stor-01-40g:9092,ares-stor-02-40g:9092,ares-stor-03-40g:9092,ares-stor-04-40g:9092 --prefix tpch. --tpch-type 10sf"
fi
