template "#{node[:monit][:conf_dir]}/nginx_logs.monitrc" do
  owner 'root'
  group 'root'
  mode 0644
  source "nginx_logs.monitrc.erb"
end
