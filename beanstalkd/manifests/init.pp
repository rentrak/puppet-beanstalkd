

listenaddress => '0.0.0.0',
listenport => '13000',
maxjobsize => '65535',
maxconnections => '1024',
binlogdir => '/var/lib/beanstalkd/binlog',
binlogfsync => undef,							
binlogsize => '10485760',
ensure => 'running',		# running, stopped, absent
packageversion => 'latest',	# latest, present, or specific version
packagename => undef,		# override package name						#got your own custom package?  override the default name/service here.
servicename => undef		# override service name

define beanstalkd::config ( #name
	$listenaddress='0.0.0.0',
	$listenport='13000',
	$maxjobsize='65535',
	$maxconnections='1024',						## results in open file limit
	$binlogdir='/var/lib/beanstalkd/binlog',
	$binlogfsync=undef,							## unset = no explicit fsync
	$binlogsize='10485760',
	#
	$ensure='running',							## running, stopped, absent
	$packageversion='latest',					#latest, present, or specific version
	$packagename=undef,							#got your own custom package?  override the default name/service here.
	$servicename=undef
) {

	case $::operatingsystem {
		ubuntu,debian: { 
			fail("$::operatingsystem unsupported by $module_name - someone needs to setup the config template file")
			#this is really just stubbed out, a debian user needs to fix this. :)
			$defaultpackagename='beanstalkd'
			$defaultservicename='beanstalkd'
			$user='beanstalkd' 
			$configfile="/etc/beanstalkd.conf" 
			$configtemplate="$module_name/debian/beanstalkd_conf.erb"	#please create me!
			$hasstatus=undef  #please fix me
			$restart=undef	  #and me too
		}
		centos,redhat: { 
			$defaultpackagename='beanstalkd'
			$defaultservicename='beanstalkd'
			$user='beanstalkd'  
			$configfile="/etc/sysconfig/beanstalkd" 
			$configtemplate="$module_name/redhat/beanstalkd_sysconfig.erb"
			$hasstatus='true'
			$restart='/etc/init.d/beanstalkd restart'
		}
		#TODO: add more OS support!
		default: { 	
			fail("ERROR [$module_name]: I don't know how to manage this OS: ${::operatingsystem}")
		}
	}

	##simply the users experience for running/stopped/absent, and use ensure to cover those bases
	case $ensure {
		absent: {
			$ourpackageversion='absent'
			$serviceenable='false'
			$serviceensure='stopped'		
		}
		running: {
			$serviceenable='true'
			$serviceensure='running'
		}
		stopped: {
			$serviceenable='false'
			$serviceensure='stopped'
		}
		default: {
			fail("ERROR [$module_name]: enable must be one of: running stopped absent")		
		}
	}
	
	#for packageversion, use what's configured unless we're set (which should only be in the absent case..)
	if ! $ourpackageversion { 
		$ourpackageversion=$packageversion 
	}
	
	#for service and package name - if we've specified one, use it. else use the default
	if $packagename == undef { $ourpackagename=$defaultpackagename } 
	 else { $ourpackagename=$packagename } 

	if $servicename == undef { $ourservicename=$defaultservicename } 
	 else { $ourservicename=$servicename } 


	package { "$ourpackagename": ensure => "$ourpackageversion" }

	service { "$ourservicename":
		enable => "$serviceenable",
		ensure => "$serviceensure",
		hasstatus => "$hasstatus",
		restart => "$restart",
		subscribe => [ Package["$ourpackagename"], File["$configfile"] ],
	}

	file { "$configfile":
		content => template("$configtemplate"),
		owner => "root",
		group => "root",
		mode  => "644", 
		require => Package["$ourpackagename"],
	} 

}

