include_recipe "deploy"

node[:deploy].each do |application, deploy|
  deploy = node[:deploy][application]

  execute "restart Rails app #{application}" do
    cwd deploy[:current_path]
    command node[:opsworks][:rails_stack][:restart_command]
    action :nothing

    # Only restart rails apps on rails-app layer. This is to prevent unicorns
    # from running on sidekiq worker servers, unless they are also web tier
    # servers.
    only_if { node[:opsworks][:instance][:layers].include?('rails-app') }
  end

  node.default[:deploy][application][:database][:adapter] = OpsWorks::RailsConfiguration.determine_database_adapter(application, node[:deploy][application], "#{node[:deploy][application][:deploy_to]}/current", :force => node[:force_database_adapter_detection])
  deploy = node[:deploy][application]
end
