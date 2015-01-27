directory "/etc/zookeeper" do
  owner "root"
  group "root"
  mode 0755
  action :create
end

template "/etc/zookeeper/serverlist" do
  source "serverlist.erb"
  mode "0644"
  owner "root"
  group "root"
end
