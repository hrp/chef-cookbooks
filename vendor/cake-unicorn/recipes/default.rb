#
# Cookbook Name:: cake-unicorn
# Recipe:: default
#
# Copyright 2013, (c) 2013 Practice Fusion
#

application   = node['cake-unicorn']['application']
base_path     = "/var/www/#{application}"
current_path  = "#{base_path}/current"
shared_path   = "#{base_path}/shared"

# Add config for cake app and unicorn
template "/etc/nginx/sites-enabled/#{application}" do
  source "nginx_unicorn.erb"
  mode 0644
  variables(
    :application => application,
    :current_path => current_path
  )
end

# Delete the default sites-enabled directories
directory "/etc/nginx/sites-enabled/default" do
  action :delete
end

# and magic symlink
link "/etc/nginx/sites-enabled/000-default" do
  action :delete
end

# Restart Nginx
service "nginx" do
  action :restart
end

# Add initializer for Unicorn
template "/etc/init.d/unicorn" do
  source "unicorn_init.erb"
  mode 0755
  variables(
    :unicorn_user => 'cake',
    :unicorn_pid  => "#{current_path}/tmp/pids/unicorn.pid",
    :unicorn_config => "#{shared_path}/config/unicorn.rb",
    :unicorn_log => "#{shared_path}/log/unicorn.log",
    :unicorn_workers => node['cake-unicorn']['workers'],
    :unicorn_timeout => node['cake-unicorn']['timeout'],
    :rails_env => node['cake-base']['rack_env'],
    :current_path => current_path
  )
end