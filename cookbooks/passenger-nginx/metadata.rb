name              'passenger-nginx-rvm'
maintainer        'Practice Fusion'
maintainer_email  'hparmar@practicefusion.com'
license           'Apache 2.0'
description       'Set iptables'
version           '1.0.0'

recipe 'passenger-nginx-rvm', 'Install passenger, nginx and rvm.'

%w{redhat centos fedora ubuntu debian freebsd}.each do |os|
  supports os
end

depends nginx