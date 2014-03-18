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
	$from,
	$to,
) {
	include backup::params
	include backup
    case $ensure {
        'present','absent': { $real_ensure = $ensure }
        default           : { fail("Invalid value \"${ensure}\" used for ensure") }
    }
	$destination = "${backup::params::endpoint}/${to}"
	if $ensure == 'present' {

		# Step-1: copy
		exec {"backup::simple::${title}::step-1":
			path    => $backup::params::envpath,
			command => "cp -Rf ${from} ${destination}",
			onlyif  => "[ ! -d ${destination} ] && [ ! -f ${destination} ]",
			before  => Exec["backup::simple::${title}::step-2"],
		}
		# Step-1: copy

		# Step-2: compress
		backup::compress {"backup::simple::${title}::step-2":
			path       => $destination,
			compressor => $compressor,
			require    => Exec["backup::simple::${title}::step-1"],
		}
		# Step-2: compress

	} else {
		file {"backup::simple::file::${to}",:
			ensure => absent,
			path   => [
				"${destination}.${compressor}",
				$destination,
			],
		}
	}
}
