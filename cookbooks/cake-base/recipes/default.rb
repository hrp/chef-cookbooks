#
# Cookbook Name:: cake-base
# Recipe:: default
#
# Copyright 2013, Practice Fusion
#
# All rights reserved - Do Not Redistribute
#

# Packages for cake
# * Rmagick
# * tesseract
# * freetds
# * curl-devel
# * screen

packages = %w'curl-devel ImageMagick ImageMagick-devel freetds freetds-devel screen'

packages.each do |pkg|
  package pkg do
    action :upgrade
  end
end

# Folders for the Rails app
directory "/var/www/cake" do
  owner "cake"
  group "cake"
  mode 00755
  action :create
  recursive true
end

# Give /var/www/cake to the cake user
script "execute" do
  interpreter "bash"
  user "root"
  cwd "/tmp"
  code <<-DOC
  chown -R cake:cake /var/www/cake
  DOC
end