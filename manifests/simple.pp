define backup::simple(
	$ensure     = present,
	$minute     = '*',
	$hour       = '*',
	$monthday   = '*',
	$month      = '*',
	$weekday    = '*',
	$user       = 'root',
	$group      = 'root',
	$mode       = 0644,
	$compressor = 'tar.gz',
	$dateformat = "%Y-%m-%d",
	$log        = '/dev/null',
	$from,
	$to,
) {
	include backup::params
	include backup
	case $ensure {
		'present','absent': {}
		default           : { fail("Invalid value \"${ensure}\" used for ensure") }
	}
	Exec {path => $backup::params::envpath}
	if $ensure == 'present' {
		
		# Backup script
		$script = "${backup::params::bkpdir}/${name}.sh"
		
		# Backup script content
		file {"backup::script::${name}":
			ensure  => present,
			owner   => root,
			group   => root,
			mode    => 0755,
			path    => $script,
			content => template('backup/simple.sh.erb'),
		}
		# Backup script content
		
		# Crontab job
		crontab::job {"backup-${name}":
			ensure   => present,
			minute   => $minute,
			hour     => $hour,
			monthday => $monthday,
			month    => $month,
			weekday  => $weekday,
			command  => $script,
			stdin    => $log,
			stderr   => $log,
		}
		# Crontab job
		
	} else {
		crontab::job {$name: ensure => absent}
	}
}
