class backup::dependencies
{
	$packages = 'backup::dependencies::packages'
	if !defined(Package[$packages]) {
		package {$packages:
			ensure => present,
			name   => $backup::params::compressors,
		}
	}
}
