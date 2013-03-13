# default configurations
default['splunk']['dest-server'] = 'hqsplunk.hq.practicefusion.com'
default['splunk']['dest-port']   = '9997'

# inputs.conf configuration
# Format : [ [ "<PATH>" , "<SOURCETYPE>", "<INDEX>" ]
default['splunk']['inputs']		= []

# URL location of splunk installer
default['splunk']['url']		 = 'http://s3.amazonaws.com/pfchefdev/binaries/splunkforwarder.rpm'

# package name
default['splunk']['pkgname']	= "splunkforwarder-5.0.1-143156-linux-2.6-x86_64"