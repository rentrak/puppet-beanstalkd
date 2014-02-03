class beanstalkd (
	$address        = $beanstalkd::params::address,
	$port           = $beanstalkd::params::port,
	$maxjobsize     = $beanstalkd::params::maxjobsize,
	$maxconnections = $beanstalkd::params::maxconnections,
	$binlogdir      = $beanstalkd::params::binlogdir,
	$binlogfsync    = $beanstalkd::params::binlogfsync,
	$binlogsize     = $beanstalkd::params::binlogsize,
	$version        = $beanstalkd::params::version,
	$package        = $beanstalkd::params::package,
	$service        = $beanstalkd::params::service

) inherits beanstalkd::params {

	package { $package:
		ensure => $version
	} ->

	file { $configfile:
		content => template($configtemplate),
		owner   => "root",
		group   => "root",
		mode    => "644",
	} ->

	service { $service:
		hasstatus => $hasstatus,
		restart   => $restart,
		subscribe => [ Package[$package], File[$configfile] ],
	}
}

