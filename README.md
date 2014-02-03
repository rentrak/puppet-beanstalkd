puppet-beanstalkd
=================
puppet module for managing beanstalkd, a simple and fast work queue

This fork is heavily refactored to follow more modern Puppet idioms and features. It's also
much simpler.

## Supported OSes

redhat/centos currently.  Please PR updates for others!

Requires packages (rpm, etc) with traditional init scripts supported by service{} for your OS.


## Basic Usage

Drop the beanstalkd directory into your modules tree and realize the define:

	class { "::beanstalkd": }

## Optional parameters

	class { "::beanstalkd":
		address        => '0.0.0.0',
		port           => '13000',
		maxjobsize     => '65535',
		maxconnections => '1024',
		binlogdir      => '/var/lib/beanstalkd/binlog',	# set empty ( '' ) to disable binlog
		binlogfsync    => undef,
		binlogsize     => '10485760',
		ensure         => 'running',		# running, stopped, absent
		version        => 'latest',	        # latest, present, or specific version
		package        => undef,		    # override package name, probably never needed
		service        => undef		        # override service name, probably never needed
    }



## Tests

Tests on this fork are undoubtedly broken. If you want to fix them, that'd be great.

To run unit tests, cd into beanstalkd and execute "run-tests.sh"

Requires ruby and bundler, everything else should get installed by the test.

```
$$ puppet-beanstalkd/beanstalkd# ./run-tests.sh
Using rake (10.0.4)
Using diff-lcs (1.2.4)
Using facter (1.7.0)
Using json_pure (1.7.7)
Using hiera (1.2.1)
Using metaclass (0.0.1)
Using mocha (0.13.3)
Using puppet (3.1.1)
Using rspec-core (2.13.1)
Using rspec-expectations (2.13.0)
Using rspec-mocks (2.13.1)
Using rspec (2.13.0)
Using rspec-puppet (0.1.6)
Using puppetlabs_spec_helper (0.4.1)
Using bundler (1.1.4)
Your bundle is complete! Use `bundle show [gemname]` to see where a bundled gem is installed.
/usr/bin/ruby1.9.1 -S rspec spec/defines/config_spec.rb
...................

Finished in 0.84772 seconds
19 examples, 0 failures
```
