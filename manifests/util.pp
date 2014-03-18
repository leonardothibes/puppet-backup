class backup::util inherits backup::util::params
{
	define chmod($file = $title, mode = 755)
	{
		exec {"chmod::${file}":
			path    => $backup::util::params::envpath,
			command => "chmod -Rf ${mode} ${file}",
			onlyif  => "[ -f ${file} ] || [ -d ${file} ]",
		}
	}
}
