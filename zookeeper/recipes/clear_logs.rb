cron "Teak - Clear ZK Logs and Snapshots" do
  minute '0'
  hour '0'
  user 'zookeeper'
  command %W{java -cp /etc/zookeeper/conf:/usr/share/java/jline-0.9.94.jar:/usr/share/java/log4j-1.2.16.jar:/usr/share/java/netty-3.7.0.Final.jar:/usr/share/java/slf4j-api-1.6.1.jar:/usr/share/java/slf4j-log4j12-1.6.1.jar:/usr/share/java/zookeeper-3.4.6.jar org.apache.zookeeper.server.PurgeTxnLog /var/lib/zookeeper /var/lib/zookeeper -n 10}
end
