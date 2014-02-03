# Parameters for the beanstalkd class
#
class beanstalkd::params {
  $address        = '0.0.0.0'
  $port           = '13000'
  $maxjobsize     = '65535'
  $maxconnections = '1024'                        ## results in open file limit
  $binlogdir      = '/var/lib/beanstalkd/binlog'  ## set empty ( '' ) to disable binlog
  $binlogfsync    = undef                         ## unset = no explicit fsync
  $binlogsize     = '10485760'

  case $::operatingsystem {
    ubuntu, debian: {
      $package        = 'beanstalkd'
      $service        = 'beanstalkd'
      $user           = 'beanstalkd'
      $configfile     = '/etc/default/beanstalkd'
      $configtemplate = "${module_name}/debian/beanstalkd_default.erb"
      $hasstatus      = true
      $restart        = '/etc/init.d/beanstalkd restart'
    }

    centos, redhat: {
      $package        = 'beanstalkd'
      $service        = 'beanstalkd'
      $user           = 'beanstalkd'
      $configfile     = '/etc/sysconfig/beanstalkd'
      $configtemplate = "${module_name}/redhat/beanstalkd_sysconfig.erb"
      $hasstatus      = true
      $restart        = '/etc/init.d/beanstalkd restart'
    }

    default: {
      fail("ERROR [${module_name}]: ${::operatingsystem} is not supported.")
    }
  }
}
