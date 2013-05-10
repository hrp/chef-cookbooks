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
# * libcurl-devel

packages = %w'libcurl-devel ImageMagick ImageMagick-devel freetds freetds-devel'

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

# Mount nfs share for scraper cache
nfs_device = if node.chef_environment == 'INT'
  "10.12.91.101:/vol/PF_INT_INDEX1/PF_INT_INDEX1_Q"
elsif node.chef_environment == 'QA'
  "10.12.91.101:/vol/PF_QA_INDEX1/PF_QA_INDEX1_Q"
elsif node.chef_environment == 'STG'
  "10.11.12.45:/vol/PF_STG_INDEX1/PF_STG_INDEX1_Q"
elsif node.chef_environment == 'PROD'
  "10.11.12.45:/vol/PF_PROD_INDEX1/PF_PROD_INDEX1_Q"
else
  nil
end

if nfs_device
  mount "/mnt/cake" do
    device nfs_device
    fstype "nfs"
    options "rw"
    action [:mount, :enable]
  end

  # Give cake user control over /mnt/cake/cache
  script "chown cake /mnt/cake/cache" do
    interpreter "bash"
    user "root"
    cwd "/tmp"
    code <<-DOC
    mkdir -p /mnt/cake/cache
    chown -R cake:cake /mnt/cake/cache
    DOC
  end
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
