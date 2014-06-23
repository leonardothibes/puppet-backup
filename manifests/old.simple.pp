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

		# Creating directory, if not exists
		exec {"backup::directory::${to}::create":
			command => "mkdir -p ${to}",
			onlyif  => "[ ! -d ${to} ]",
		}
		# Creating directory, if not exists

		# Making backup file name
		$basename = basename($to)
		$date     = strftime($dateformat)
		$bkpname  = "${basename}_${date}"
		$endpoint = "${to}/${bkpname}"
		# Making backup file name

		exec {"backup::simple::${title}::step-1":
			# Step-1: copy
			command => "cp -Rf ${from} ${endpoint}",
			onlyif  => "[ ! -d ${endpoint} ] && [ ! -f ${endpoint}.${compressor} ]",
			require => Exec["backup::directory::${to}::create"],
			# Step-1: copy
		}->util::compress {"backup::simple::${title}::step-2":
			# Step-2: compress
			from => $from,
			to   => "${endpoint}.${compressor}",
			# Step-2: compress
		}->exec {"backup::simple::${title}::step-3":
			# Step-3: clean
			command => "rm -Rf ${endpoint}",
			onlyif  => "[ -f ${endpoint}.${compressor} ]"
			# Step-3: clean
		}->util::chown {"backup::simple::${title}::step-4":
			# Step-4: chown
			file      => $to,
			user      => $user,
			group     => $group,
			recursive => true,
			# Step-4: chown
		}->util::chmod {"backup::simple::${title}::step-5":
			# Step-5: chmod
			file => "${endpoint}.${compressor}",
			mode => $chmod,
			# Step-5: chmod
		}
	} else {
		exec {"backup::simple::${to}::absent":
			command => "rm -Rf ${to}",
			onlyif  => "[ -f ${to} ]",
		}
	}
}
