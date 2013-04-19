puppet-beanstalkd
=================

puppet module for managing beanstalkd


## Supported OSes

redhat/centos currently.  Please PR updates for others!

## Basic Usage

	beanstalkd::config{"my beanstalk install": }

## Optional parameters

listenaddress => '0.0.0.0',
listenport => '13000',
maxjobsize => '65535',
maxconnections => '1024',
binlogdir => '/var/lib/beanstalkd/binlog',
binlogfsync => undef,							
binlogsize => '10485760',
ensure => 'running',		# running, stopped, absent
packageversion => 'latest',	# latest, present, or specific version
packagename => undef,		# override package name						
servicename => undef		# override service name



