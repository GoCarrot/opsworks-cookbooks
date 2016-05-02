#
# Cookbook Name:: sidekiq
# Recipe:: shutdown
#

node[:deploy].each do |application, deploy|
  execute "shutdown-sidekiq" do
    command %Q{
      echo "monit -g sidekiq_#{application} stop all" | at now
    }
  end
end
