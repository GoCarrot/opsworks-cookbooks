template "#{node[:monit][:conf_dir]}/sidekiq_logs.monitrc" do
  owner 'root'
  group 'root'
  mode 0644
  source "sidekiq_logs.monitrc.erb"
end
