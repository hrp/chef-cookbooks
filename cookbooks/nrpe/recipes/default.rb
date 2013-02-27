#
# Cookbook Name:: nrpe
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# this will install nrpe for CentOS and set up basic Linux stat configs

# node's json file will specify the nagios server to use
nagios_server_ip = node['nrpe']['nagios_server_ip']

remote_file "/tmp/linux-nrpe-agent.tar.gz" do
  source "http://assets.nagios.com/downloads/nagiosxi/agents/linux-nrpe-agent.tar.gz"
  mode "0644"
end

script "install_nrpe_agent" do
  interpreter "bash"
  user "root"
  cwd "/tmp"
  code <<-EOH
    tar zxf linux-nrpe-agent.tar.gz
    cd linux-nrpe-agent
    ./fullinstall --non-interactive <<EOM
    #{nagios_server_ip}
    EOM
  EOH
end

# install perl module needed for the check_linux_stats script
package "perl-Sys-Statistics-Linux" do
  action :install
end

# replace stock nrpe.cfg with core config for linux stats
cookbook_file "/usr/local/nagios/etc/nrpe.cfg" do
  source "core_nrpe.cfg" 
  mode "0664"
  owner "nagios"
  group "nagios"
end

# add scripts used for stats
cookbook_file "/usr/local/nagios/libexec/check_linux_stats.pl" do
   source "check_linux_stats.pl"
   mode "0755"
   owner "nagios"
   group "nagios"
end
cookbook_file "/usr/local/nagios/libexec/check_diskstat" do
   source "check_diskstat"
   mode "0755"
   owner "nagios"
   group "nagios"
end
