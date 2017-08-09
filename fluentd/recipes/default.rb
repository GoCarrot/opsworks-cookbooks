gem_package "fluentd" do
  version "0.12.31"
end

gem_package "fluent-plugin-mysql" do
  source "https://repo.fury.io/alexsc/"
  version "0.1.5.1"
end

gem_package "fluent-plugin-sidekiq"
gem_package "fluent-plugin-bufferize"
gem_package "fluent-plugin-out-http"
gem_package "fluent-plugin-cloudwatch-logs" do
  source "https://repo.fury.io/alexsc/"
  version "0.4.1"
end

user "fluent" do
  comment "fluent Administrator"
  supports :manage_home => false
  system true
end

group "fluent" do
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
  notifies :restart, 'service[fluentd]'
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
