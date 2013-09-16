# Parameters for the beanstalkd class
#
class beanstalkd::params {
  case $::operatingsystem {
    ubuntu,debian: {
      $defaultpackagename='beanstalkd'
      $defaultservicename='beanstalkd'
      $user='beanstalkd'
      $configfile='/etc/default/beanstalkd'
      $configtemplate="${module_name}/debian/beanstalkd_default.erb"  # please create me!
      $hasstatus=true
      $restart='/etc/init.d/beanstalkd restart'
    }
    centos,redhat: {
      $defaultpackagename='beanstalkd'
      $defaultservicename='beanstalkd'
      $user='beanstalkd'
      $configfile='/etc/sysconfig/beanstalkd'
      $configtemplate="${module_name}/redhat/beanstalkd_sysconfig.erb"
      $hasstatus=true
      $restart='/etc/init.d/beanstalkd restart'
    }
    # TODO: add more OS support!
    default: {
      fail("ERROR [${module_name}]: I don't know how to manage this OS: ${::operatingsystem}")
    }
  }


  $valid_ensure_values = [ 'present', 'absent', 'purged', 'latest' ]


}
