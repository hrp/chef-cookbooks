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