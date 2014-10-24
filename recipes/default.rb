#
# Cookbook Name:: ops-tools
# Recipe:: default
#
# Copyright 2014, okisanjp
#

# zabbix-agent
remote_file "/tmp/zabbix-release-2.0-1.el6.noarch.rpm" do
  source "http://repo.zabbix.com/zabbix/2.0/rhel/6/x86_64/zabbix-release-2.0-1.el6.noarch.rpm"
  mode "0644"
end
package "zabbix-release" do
  source "/tmp/zabbix-release-2.0-1.el6.noarch.rpm"
  action :install
  provider Chef::Provider::Package::Rpm
end

package "zabbix-agent" do
  action :install
end

template "/etc/zabbix/zabbix_agentd.conf" do
  path "/etc/zabbix/zabbix_agentd.conf"
  owner "root"
  source "zabbix_agentd.conf.erb"
end

service "zabbix-agent" do
  action :restart
end
