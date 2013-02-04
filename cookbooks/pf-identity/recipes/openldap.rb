#
# Cookbook Name:: pf-identity
# Recipe:: openldap
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# install yum prerequisites
%w(openldap-servers openldap-clients ntp).each do |pkg|
	package pkg do
		action :upgrade
	end
end

# define the tomcat6 service.
service "tomcat6" do
  action [:enable, :start]
  supports :status => true, :start => true, :stop => true, :restart => true
end