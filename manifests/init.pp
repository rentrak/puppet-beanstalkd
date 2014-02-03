class beanstalkd (
	$address        = beanstalkd::params::address,
	$port           = beanstalkd::params::port,
	$maxjobsize     = beanstalkd::params::maxjobsize,
	$maxconnections = beanstalkd::params::maxconnections,
	$binlogdir      = beanstalkd::params::binlogdir,
	$binlogfsync    = beanstalkd::params::binlogfsync,
	$binlogsize     = beanstalkd::params::binlogsize,
	$version        = 'latest',
	$package        = undef,
	$service        = undef
) inherits beanstalkd::params {

	file { $configfile:
		content => template($configtemplate),
		owner   => "root",
		group   => "root",
		mode    => "644",
		require => Package[$package],
	} ->

	service { $service:
		hasstatus => $hasstatus,
		restart   => $restart,
		subscribe => [ Package[$package], File[$configfile] ],
	}
}

