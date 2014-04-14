template "/etc/zookeeper/conf/zoo.cfg" do
  source "zoo.cfg.erb"
  owner "root"
  group "root"
  mode 0664
end

template "/var/lib/zookeeper/myid" do
  source "myid.erb"
  owner "zookeeper"
  group "zookeeper"
  mode 0664
end

service "zookeeper" do
  provider Chef::Provider::Service::Upstart
  action :restart
  running true
  supports :status => true, :restart => true
end
