#
# Cookbook Name:: clockwork
# Recipe:: default
#

node[:deploy].each do |application, deploy|
  next if !deploy[:clockwork]
  next if !deploy[:scm]
  opsworks_clockwork application do
    working_directory "#{deploy[:deploy_to]}/current"
    pid_dir "#{deploy[:deploy_to]}/shared/pids"
    log_dir "#{deploy[:deploy_to]}/shared/logs"
    user "deploy"
  end
end
