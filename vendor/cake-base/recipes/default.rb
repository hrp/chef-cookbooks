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

# Give cake user control over /mnt/cake
script "chown cake /mnt/cake" do
  interpreter "bash"
  user "root"
  cwd "/tmp"
  code <<-DOC
  chown -R cake:cake /mnt/cake
  DOC
end

script "set group" do
  interpreter "bash"
  user "root"
  cwd "/tmp"
  code 'find /var/www -type d -exec chmod 2775 {} \;'
end

script "set user" do
  interpreter "bash"
  user "root"
  cwd "/tmp"
  code 'find /var/www -type f -exec chmod ug+rw {} \;'
end
