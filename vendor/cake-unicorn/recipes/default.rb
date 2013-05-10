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
x_forwarded_proto = node['cake-unicorn']['x_forwarded_proto'] || '$scheme'

# Add config for cake app and unicorn
template "/etc/nginx/sites-enabled/#{application}" do
  source "nginx_unicorn.erb"
  mode 0644
  variables(
    :application => application,
    :current_path => current_path,
    :x_forwarded_proto => x_forwarded_proto
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

# install unicorn in an rvm-aware environment
# rvm_global_gem "unicorn"

# wrap the rvm-aware unicorn for use in the init.d
# rvm_wrapper "cake" do
#   prefix "cake"
#   ruby_string "default"
#   binary "unicorn"
# end

unicorn_binary = File.join(current_path, 'bin/unicorn')

# try using direct command-line
# execute "create cake_unicorn wrapper" do
#   command "rvm wrapper default cake unicorn"
#   not_if { ::File.exists?(unicorn_binary) }
# end

# Add initializer for Unicorn
template "/etc/init.d/unicorn" do
  source "unicorn_init.erb"
  mode 0755
  variables(
    :unicorn_user => 'cake',
    :unicorn_binary => unicorn_binary,
    :unicorn_pid  => "#{current_path}/tmp/pids/unicorn.pid",
    :unicorn_config => "#{shared_path}/config/unicorn.rb",
    :unicorn_log => "#{shared_path}/log/unicorn.log",
    :unicorn_workers => node['cake-unicorn']['workers'],
    :unicorn_timeout => node['cake-unicorn']['timeout'],
    :rails_env => node['cake-base']['rack_env'],
    :current_path => current_path
  )
end
