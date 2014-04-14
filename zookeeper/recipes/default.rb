  src_filepath  = "#{Chef::Config['file_cache_path'] || '/tmp'}/zookeeper-3.4.6.tar.gz"
  remote_file src_filepath do
    source node[:zookeeper][:url]
    checksum node[:zookeeper][:checksum]
    backup false
  end

bash "untar zookeeper" do
  user "root"
  cwd "/tmp"
  code %(tar zxf #{::File.basename(src_filepath)} -C #{::File.dirname(src_filepath)})
  not_if { File.exists? ::File.dirname(src_filepath) }
end

bash "copy zookeeper root" do
  user "root"
  cwd "/tmp"
  code %(cp -r #{::File.dirname(src_filepath)}/* /usr/share/java/)
end

user "zookeeper" do
  comment "zookeeper Administrator"
  supports :manage_home => false
  system true
end

group "zookeeper" do
end

directory "/etc/zookeeper" do
  owner "root"
  group "root"
  mode 0755
  action :create
end

%w{ configuration.xsl log4j.properties environment }.each do |templ|
   template "/etc/zookeeper/#{templ}" do
      source "#{templ}.erb"
      mode "0644"
      owner "root"
      group "root"
   end
end

directory "/var/log/zookeeper" do
  owner "zookeeper"
  group "zookeeper"
  mode 0755
  action :create
end

directory "/var/lib/zookeeper" do
  owner "zookeeper"
  group "zookeeper"
  mode 0755
  action :create
end

template "/etc/init/zookeeper.conf" do
  source "zookeeperd.conf.erb"
  owner "root"
  group "root"
end

include_recipe "zookeeper::update_cluster"
