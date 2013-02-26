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
  variables(
    :application => application,
    :current_path => "/var/www/#{application}"
  )
end

# Delete the default sites-enabled directories
directories = %w'/etc/nginx/sites-enabled/default /etc/nginx/sites-enabled/000-default'
directories.each do |dir|
  directory dir do
    action :delete
  end
end

# Add initializer for Unicorn
template "/etc/init.d/unicorn" do
  source "unicorn_init.erb"
  variables(
    :unicorn_user => 'cake',
    :unicorn_pid  => "#{current_path}/tmp/pids/unicorn.pid",
    :unicorn_config => "#{shared_path}/config/unicorn.rb",
    :unicorn_log => "#{shared_path}/log/unicorn.log",
    :unicorn_workers => node['cake-unicorn']['workers'],
    :unicorn_timeout => node['cake-unicorn']['timeout'],
    :rails_env => node['cake-base']['rack_env']
  )
end