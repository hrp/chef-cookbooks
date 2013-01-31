# Make sure Passenger requirements are installed
package "curl-devel" do
  action :upgrade
end

# fix the env variable

script "install_something" do
  interpreter "bash"
  user "root"
  cwd "/tmp"
  code <<-EOH
  source /etc/profile.d/rvm.sh
  EOH
end

gem_package "passenger"
gem_package "rake"

nginx_prefix = '/opt/nginx'

nginx_binary = "#{nginx_prefix}/sbin/nginx"
nginx_installed = ::File.exists?(nginx_binary) && ::File.executable?(nginx_binary)

# Install Passenger/Nginx with simple installer
script "install" do
  not_if {nginx_installed}

  interpreter "bash"
  user "root"
  cwd "/tmp"
  code <<-DOC
passenger-install-nginx-module --auto --auto-download --prefix=#{nginx_prefix} --extra-configure-flags=none
  DOC
end

directory "#{nginx_prefix}/conf" do
  owner "root"
  group "root"
  mode 00755
  action :create
  recursive true
end

template "nginx.conf" do
  path "#{nginx_prefix}/conf/nginx.conf"
  source "nginx.conf.erb"
  owner "root"
  group "root"
  mode 00644
end

directory "/var/www/cake" do
  owner "cake"
  group "cake"
  mode 00755
  action :create
  recursive true
end

script "execute" do
  interpreter "bash"
  user "root"
  cwd "/tmp"
  code <<-DOC
  chown -R cake:cake /var/www/cake
  DOC
end

template "/etc/init.d/nginx" do
  path "/etc/init.d/nginx"
  source "initd_nginx.erb"
  owner "root"
  group "root"
  mode 00755
end

service "nginx" do
  supports :restart => true, :restart => true
  action [:enable, :start]
end

#Packages for cake
# for Rmagick, tesseract, freetds

packages = %w'ImageMagick ImageMagick-devel freetds freetds-devel'

packages.each do |pkg|
  package pkg do
    action :upgrade
  end
end

# Trust all rvmrcs
file "/home/cake/.rvmrc" do
  owner "cake"
  group "cake"
  mode 00755
  content "export rvm_trust_rvmrcs_flag=1"
end