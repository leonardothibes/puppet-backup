puppet-backup
=============

A puppet module to manage backups.

## Sample Usage
Install backup and use the provided configuration defaults:
```puppet
node default {
	class {'backup':}
}
```
or
```puppet
node default {
	include backup
}
```

Uninstall backup:
```puppet
node default {
	class {'backup':
		ensure => absent,
	}
}
```

Contact
-------

Principal developer:
	[Leonardo Thibes](http://leonardothibes.com) => [eu@leonardothibes.com](mailto:eu@leonardothibes.com)

Support
-------

Please log tickets and issues at our [Projects site](https://github.com/leonardothibes/puppet-backup/issues)
