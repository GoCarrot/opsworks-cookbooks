# msgpack 1.4.x changed the minimum required ruby version from 0 to 2.4
# Until we're on Ruby 2.4+, pin to msgpack 1.3.3
gem_package "msgpack" do
  version "1.3.3"
end

gem_package "fluentd" do
  version "0.14.25"
end

gem_package "fluent-plugin-mysql" do
  source "https://repo.fury.io/alexsc/"
  version "0.1.5.2"
end

gem_package "fluent-plugin-sidekiq" do
  version "0.0.5"
end

gem_package "fluent-plugin-bufferize" do
  version "0.0.2"
end

gem_package "fluent-plugin-out-http" do
  version "1.2.0"
end

gem_package "fluent-plugin-cloudwatch-logs" do
  source "https://repo.fury.io/alexsc/"
  version "0.4.2"
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
