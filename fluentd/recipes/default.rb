bash "install-fluentd-and-friends" do
  code "gem install fluentd --no-ri --no-rdoc"
  code "gem install fluent-plugin-mysql --no-ri --no-rdoc"
end

user "fluent" do
  comment "fluent Administrator"
  supports :manage_home => false
  system true
end

directory "/etc/fluent" do
  owner "fluent"
  group "fluent"
  mode 0755
  action :create
end

directory "/var/log/fluent" do
  owner "fluent"
  group "fluent"
  mode 0755
  action :create
end

template "/etc/fluent/fluent.conf" do
  source "fluent.conf.erb"
  owner "fluent"
  group "fluent"
  mode 0664
end

template "/etc/init/fluentd.conf" do
  source "fluentd.conf.erb"
  owner "root"
  group "root"
end

service "fluentd" do
  provider Chef::Provider::Service::Upstart
  action :start
end
