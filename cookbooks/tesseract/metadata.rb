name              'tesseract'
maintainer        'Practice Fusion'
maintainer_email  'hparmar@practicefusion.com'
license           'Apache 2.0'
description       'Set iptables'
version           '1.0.0'

recipe 'tesseract', 'Install tesseract from source on CentOS 6.'

%w{centos}.each do |os|
  supports os
end