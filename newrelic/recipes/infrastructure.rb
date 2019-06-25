template "/etc/newrelic-infra.yml" do
    source "newrelic.cfg.erb"
    owner "root"
    group "root"
    mode "0644"
    variables(
        :license => node[:newrelic][:infrastructure][:license_key]
    )
    action :create
end

execute 'add-newrelic-repo' do
    user "root"
    command "curl -o /etc/yum.repos.d/newrelic-infra.repo https://download.newrelic.com/infrastructure_agent/linux/yum/el/6/x86_64/newrelic-infra.repo && yum -q makecache -y --disablerepo='*' --enablerepo='newrelic-infra'"
    only_if do !File.exists?("/etc/yum.repos.d/newrelic-infra.repo") end
end

package "newrelic-infra" do
    action :install
end
