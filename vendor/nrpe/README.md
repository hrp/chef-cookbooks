Description
===========

Cookbook to install Nagios XI nrpe agent for CentOS 6.

Requirements
============

Attributes
==========

Usage
=====

The default recipe just needs to be fed the IP address of the Nagios XI server it will talk with in the node.json.

Example:

"nrpe": {
		"nagios_server_ip": "10.12.13.32"
	},

"run_list": [ "recipe[nrpe]"
	    ]
