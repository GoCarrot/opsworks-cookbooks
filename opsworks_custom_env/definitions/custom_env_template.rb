# Accepts:
#   application (application name)
#   deploy (hash of deploy attributes)
#   env (hash of custom environment settings)
# 
# Notifies a "restart Rails app <name>" resource.

define :custom_env_template do
  
  template "#{params[:deploy][:deploy_to]}/shared/config/application.yml" do
    source "application.yml.erb"
    owner params[:deploy][:user]
    group params[:deploy][:group]
    mode "0660"
    variables :env => params[:env].merge(params[:deploy][:environment].to_hash)
    notifies :run, resources(:execute => "restart Rails app #{params[:application]}")

    only_if { File.exists?("#{params[:deploy][:deploy_to]}/shared/config") }
  end
  
end
