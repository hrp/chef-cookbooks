name              'set-iptables'
maintainer        'Practice Fusion'
maintainer_email  'hparmar@practicefusion.com'
license           'All Rights Reserved'
description       'Set iptables'
version           '1.1.1'

recipe 'set-iptables', 'Adds iptables'

depends "simple_iptables"

%w{redhat centos fedora ubuntu debian freebsd}.each do |os|
  supports os
end