#
# Cookbook Name:: pf-identity
# Recipe:: selinux
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# disable current setting.
execute "disable selinux enforcement" do
  only_if "selinuxenabled"
  command "setenforce 0"
  action :run
end

# script "disbabling selinux" do
#   interpreter "bash"
#   user "root"
#   cwd "/tmp"
#   code <<-EOH
  
#   EOH
# end

# permanently disable
template "/etc/selinux/config" do
  source "selinux.erb"
  variables(
    :selinux => "disabled",
    :selinuxtype => "targeted"
  )
end