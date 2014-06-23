define backup::simple(
	$ensure     = present,
    $minute     = '*',
    $hour       = '*',
    $monthday   = '*',
    $month      = '*',
    $weekday    = '*',
    $user       = 'root',
	$group      = 'root',
	$chmod      = 0644,
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
		crontab::job {$name:
			ensure => present,
			
		}
	} else {
		crontab::job {$name: ensure => absent}
	}
}
