class backup::dependencies
{
	$packages = 'backup::dependencies::packages'
	if !defined(Package[$packages]) {
		package {$packages:
			ensure => present,
			name   => $backup::params::compactors,
		}
	}

	$directory = 'backup::dependencies::directory'
	if !defined(File[$directory]) {
		file {$directory:
			ensure => directory,
			owner  => root,
			group  => root,
			mode   => 0755,
			path   => $backup::params::endpoint,
		}
	}
}
