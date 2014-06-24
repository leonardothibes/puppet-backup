# The baseline for module testing used by Puppet Labs is that each manifest
# should have a corresponding test manifest that declares that class or defined
# type.
#
# Tests are then run by using puppet apply --noop (to check for compilation
# errors and view a log of events) or by fully applying the test in a virtual
# environment (to compare the resulting system state to the desired state).
#
# Learn more about module testing here:
# http://docs.puppetlabs.com/guides/tests_smoke.html
#
include vim
backup::simple {'temp':
	from   => '/tmp',
	to     => '/backups/tmp',
	user   => 'vagrant',
	group  => 'backup',
	log    => '/tmp/bkp.log',
	minute => 1,
}

#backup::simple {'backup of /tmp/vagrant-shell file':
#	from => '/tmp/vagrant-shell',
#	to   => 'shell/shell-scripts',
#}
