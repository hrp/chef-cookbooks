maintainer       "Benson Wu"
maintainer_email "bwu@practicefusion.com"
license          "Apache 2.0"
description      "Installs/Configures apache2"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1.0"

recipe "apache2", "Installs and configures apache2"

%w{ redhat fedora centos }.each do |os|
  supports os
end

attribute "apache2/environment",
  :display_name => "Apache2 environment",
  :description => "Environment for apache2",
  :default => "Prod"