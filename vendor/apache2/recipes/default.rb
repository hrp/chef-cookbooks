#
# Cookbook Name:: apache2
# Recipe:: default
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

# install needed packages
package "httpd" do
  action :upgrade
end

# turn on service
service "httpd" do
  action :enable
  supports :status => true, :start => true, :stop => true, :restart => true, :reload => true
end

# run configuration
include_recipe "apache2::config"