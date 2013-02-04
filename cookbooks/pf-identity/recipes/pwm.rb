#
# Cookbook Name:: pf-identity
# Recipe:: pwm
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# install yum prerequisites
%w(java-1.7.0-openjdk tomcat6 tomcat6-admin-webapps).each do |pkg|
	package pkg do
		action :upgrade
	end
end

# define the tomcat6 service.
service "tomcat6" do
  action :nothing
  supports :status => true, :start => true, :stop => true, :restart => true
end

# download the libraries.
remote_file "/tmp/#{node['pf-identity']['jaxfile']}" do
  source "#{node['pf-identity']['jaxurl']}#{node['pf-identity']['jaxfile']}"
  mode 00644
  # creates
end

script "jaxws libraries installation" do
  interpreter "bash"
  user "root"
  cwd "/tmp"
  code <<-EOH
  tar -zxf jaxwslib.tar.gz --overwrite-dir --overwrite -C /usr/share/tomcat6/lib
  EOH
end

# install the tomcat users xml
template "/etc/tomcat6/tomcat-users.xml" do
  owner         "tomcat"
  group         "tomcat"
  mode          "0644"
  #variables     template_variables
  source        "tomcat-users.xml.erb"
  notifies :restart, resources(:service => "tomcat6"), :delayed
end