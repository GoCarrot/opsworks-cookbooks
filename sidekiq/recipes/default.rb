#
# Cookbook Name:: sidekiq
# Recipe:: default
#

node[:deploy].each do |application, deploy|
  next if !deploy[:sidekiq]
  next if !deploy[:scm]
  (deploy[:sidekiq_count] || 1).to_i.times do |idx|
    template "#{node[:monit][:conf_dir]}/sidekiq_#{application}_#{idx}.monitrc" do
      owner 'root'
      group 'root'
      mode 0644
      source "monitrc.conf.erb"
      variables({
        :app_name => application,
        :deploy => deploy,
        :idx => idx
      })
    end
  end

  execute "ensure-sidekiq-is-setup-with-monit" do
    command %Q{
      monit reload
    }
  end

  execute "restart-sidekiq" do
    command %Q{
      echo "sleep 20 && monit -g sidekiq_#{application} restart all" | at now
    }
  end
end
