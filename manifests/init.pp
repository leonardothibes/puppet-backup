class backup inherits backup::params
{
	include backup::dependencies
	
	# Creatong backup directory
	file {'backup::bkpdir':
		ensure => directory,
		owner  => root,
		group  => root,
		mode   => 0755,
		path   => $backup::params::bkpdir,
	}
	# Creatong backup directory
}
