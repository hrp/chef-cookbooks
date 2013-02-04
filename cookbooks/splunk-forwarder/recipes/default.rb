#
# Cookbook Name:: splunk-forwarder
# Recipe:: default
#
# Copyright 2013, Practice Fusion
#
# All rights reserved - Do Not Redistribute
#

splunk_file = 'splunkforwarder.rpm'

# install splunk-forwarder
remote_file "#{Chef::Config['file_cache_path']}/#{splunk_file}" do
  source "http://s3.amazonaws.com/pfchefdev/binaries/splunkforwarder.rpm"
  action :create_if_missing
end

package splunk_package_version do
  source "#{Chef::Config['file_cache_path']}/#{splunk_file}"
  case node['platform']
  when "centos","redhat","fedora"
    provider Chef::Provider::Package::Rpm
  when "debian","ubuntu"
    provider Chef::Provider::Package::Dpkg
  end
end

# create service
service "splunk" do
  action [ :nothing ]
  supports :status => true, :start => true, :stop => true, :restart => true
end

# install outputs.conf
template "/opt/splunkforwarder/etc/system/local/outputs.conf"
	source "outputs.conf.erb"
end

# install inputs.conf
template "/opt/splunkforwarder/etc/system/local/inputs.conf" do
	source "inputs.conf.erb"
end

service "splunk" do
	action [ :restart ]
end