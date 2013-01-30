#
# Cookbook Name:: apache2
# Recipe:: configs
#
# This recipe is specific to the Practice Fusion www configuration
# Will not work well for others without heavy modification
#
# Copyright 2012, Benson Wu
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# # install custom conf files to be included.
# template "/srv/confs/httpd/001-practicefusion.com"
#   source "001-practicefusion.com.erb"
#   owner "root"
#   group "root"
#   mode "0644"

# template "/srv/confs/httpd/002-learn.practicefusion.com"
#   source "002-learn.practicefusion.com.erb"
#   owner "root"
#   group "root"
#   mode "0644"

# template "/srv/confs/httpd/003-support.practicefusion.com"
#   source "003-support.practicefusion.com.erb"
#   owner "root"
#   group "root"
#   mode "0644"

# template "/srv/confs/httpd/004-stg-research.practicefusion.com"
#   source "004-stg-research.practicefusion.com.erb"
#   owner "root"
#   group "root"
#   mode "0644"

# template "/srv/confs/httpd/005-ehrbloggers"
#   source "005-ehrbloggers.erb"
#   owner "root"
#   group "root"
#   mode "0644"

# template "/srv/confs/httpd/006-request.practicefusion.com"
#   source "006-request.practicefusion.com.erb"
#   owner "root"
#   group "root"
#   mode "0644"

# template "/srv/confs/httpd/007-redirects"
#   source "001-practicefusion.com.erb"
#   owner "root"
#   group "root"
#   mode "0644"

# # install conf files
# template "/etc/httpd/httpd.conf" do
#   source "httpd.conf.erb"
#   owner "root"
#   group "root"
#   mode "0644"
# #  variables(
# #    :listen => node[:memcached][:listen],
# #    :user => node[:memcached][:user],
# #    :port => node[:memcached][:port],
# #    :maxconn => node[:memcached][:maxconn],
# #    :memory => node[:memcached][:memory]
# #  )
# notifies :reload, resources(:service => "httpd"), :immediately

# start service
service "httpd" do
  action :start
end
