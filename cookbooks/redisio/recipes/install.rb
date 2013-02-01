#
# Cookbook Name:: redisio
# Recipe:: install
#
# Copyright 2012, Brian Bianco <brian.bianco@gmail.com>
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
include_recipe 'redisio::default'

redis = node['redisio']
location = "#{redis['mirror']}/#{redis['base_name']}#{redis['version']}.#{redis['artifact_type']}"

redis_instances = if redis['servers'].nil?
                    [{'port' => '6379'}]
                  else
                    redis['servers']
                  end

redisio_install "redis-servers" do
  version redis['version']
  download_url location
  default_settings redis['default_settings']
  servers redis_instances
  safe_install redis['safe_install']
  base_piddir redis['base_piddir']
end

# Create a service resource for each redis instance
redis_instances.each do |current_server|
  server_name = current_server['name'] || current_server['port']
  service "redis#{server_name}" do
    start_command "/etc/init.d/redis#{server_name} start"
    stop_command "/etc/init.d/redis#{server_name} stop"
    status_command "pgrep -lf 'redis.*#{server_name}' | grep -v 'sh'"
    restart_command "/etc/init.d/redis#{server_name} stop && /etc/init.d/redis#{server_name} start"
    supports :start => true, :stop => true, :restart => true, :status => false
  end
end

node.set['redisio']['servers'] = redis_instances 

