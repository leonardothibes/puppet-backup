class backup::dependencies inherits backup::params
{
	$resource = 'php::backup::dependencies::packages'
	if !defined(Package[$resource]) {
		package {$resource:
			ensure => present,
			name   => $backup::params::packages,
		}
	}
}
