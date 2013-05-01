puppet-beanstalkd
=================
[![Build Status](https://travis-ci.org/keen99/puppet-beanstalkd.png?branch=master)](https://travis-ci.org/keen99/puppet-beanstalkd)

puppet module for managing beanstalkd, a simple and fast work queue - https://github.com/kr/beanstalkd


## Supported OSes

redhat/centos currently.  Please PR updates for others!  

Requires packages (rpm, etc) with traditional init scripts supported by service{} for your OS.


## Basic Usage

Drop the beanstalkd directory into your modules tree and realize the define:

	beanstalkd::config{"my beanstalk install": }

## Optional parameters
	
	listenaddress => '0.0.0.0',
	listenport => '13000',
	maxjobsize => '65535',
	maxconnections => '1024',
	binlogdir => '/var/lib/beanstalkd/binlog',	# set empty ( '' ) to disable binlog
	binlogfsync => undef,							
	binlogsize => '10485760',
	ensure => 'running',		# running, stopped, absent
	packageversion => 'latest',	# latest, present, or specific version
	packagename => undef,		# override package name						
	servicename => undef		# override service name



