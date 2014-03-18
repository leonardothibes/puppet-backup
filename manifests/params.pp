class backup::params
{
	$endpoint = "/backups"
	$envpath  = [
		'/bin',
		'/sbin',
		'/usr/bin',
		'/usr/sbin',
		'/usr/local/bin',
		'/usr/local/sbin',
	]
	$compressors = [
		'tar',
		'gzip',
		'bzip2',
		'zip',
	]
}
