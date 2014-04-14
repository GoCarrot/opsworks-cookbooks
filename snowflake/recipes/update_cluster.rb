service "snowflake" do
  provider Chef::Provider::Service::Upstart
  action :enable
  supports :status => true, :restart => true
end

template "/etc/snowflake/snowflake.scala" do
  source "snowflake.scala.erb"
  mode "0644"
  owner "root"
  group "root"
  notifies :restart, resources(:service => "snowflake")
end

template "/etc/snowflake/serverlist" do
  source "serverlist.erb"
  mode "0644"
  owner "root"
  group "root"
end
