# default configurations
default['splunk']['dest-server'] = 'hqsplunk.hq.practicefusion.com'
default['splunk']['dest-port']   = '9997'

# inputs.conf configuration
# Format : [ [ "<PATH>" , "<SOURCETYPE>", "<INDEX>" ]
default['splunk']['inputs']		= [ [ 'c:\logs\PF.PlatformServices\*.log' , 'platformservices', 'pfaws' ] , [ 'c:\logs\PF.Listeners\*.log' , 'pflisteners' , 'pfaws' ] ]

# URL location of splunk installer
default['splunk']['url']		 = 'http://s3.amazonaws.com/pfchefdev/binaries/splunkforwarder.rpm'