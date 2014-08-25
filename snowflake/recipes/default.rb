user "snowflake" do
  comment "snowflake Administrator"
  supports :manage_home => false
  system true
end

group "snowflake" do
end

directory "/usr/share/snowflake" do
  owner "root"
  group "root"
  mode 0755
  action :create
end

directory "/usr/share/snowflake/libs" do
  owner "root"
  group "root"
  mode 0755
  action :create
end

src_filepath  = "#{Chef::Config['file_cache_path'] || '/tmp'}/snowflake-package-dist.tar.gz"
remote_file src_filepath do
  source node[:snowflake][:url]
  checksum node[:snowflake][:checksum]
  backup false
end

bash "untar snowflake" do
  user "root"
  cwd "/tmp"
  code %(tar zxf #{src_filepath})
end

bash "copy snowflake root" do
  user "root"
  cwd "/tmp"
  code %(cp -r snowflake-package-dist/* /usr/share/snowflake)
end

directory "/var/log/snowflake" do
  owner "snowflake"
  group "snowflake"
  mode 0755
  action :create
end

template "/etc/init/snowflake.conf" do
  source "snowflaked.conf.erb"
  owner "root"
  group "root"
end

include_recipe "snowflake::update_cluster"
