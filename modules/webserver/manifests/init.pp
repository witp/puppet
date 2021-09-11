class webserver (
		$packagename     = $::webserver::parameters::packagename,
		$configfile      = $::webserver::parameters::configfile,
		$configsource    = $::webserver::parameters::configsource,
		$vhostfile       = $::webserver::parameters::vhostfile,
		$defindex        = $::webserver::parameters::defindex,
		$defindexsrc     = $::webserver::parameters::defindexsrc  
		) inherits ::webserver::parameters {
	package { 'webserver-package':
		name   => $packagename,	
		ensure => installed,
	}

	file { 'config-file':
		path    => $configfile,
		ensure  => file,
		source  => $configsource,
		require => Package['webserver-package'],
	}
		
	file { 'vhost-file':
		path    => $vhostfile,
		ensure  => file,
		content => template('webserver/vhost.conf.erb'),
		require => Package['webserver-package'],
	}

	file { 'default-index':
		path    => $defindex,
		ensure  => file,
		source  => $defindexsrc,
		require => Package['webserver-package'],
	}

	service { 'webserver-service':
		name       => $packagename,
		ensure     => running,
		enable     => true,
		hasrestart => true,
		require    => [ File['config-file'], File['vhost-file'] ],
		subscribe  => [ File['config-file'], File['vhost-file'] ],
	}

	package { [ 'ruby', 'cowsay', 'htop', 'vim', 'iotop', 'sudo', 'systemd', 'net-tools', ]:
		ensure => installed,
	}

	package { 'puppet-lint':
  		ensure   => installed,
  		provider => gem,
	}
	
	file { '/etc/motd':
		source => 'puppet:///modules/webserver/motd.txt',
	}

	ssh_authorized_key { 'przemyslaw@monterosa.co.uk':
		user  => 'pw',
		type  => 'ssh-rsa',
		key   => 'AAAAB3NzaC1yc2EAAAADAQABAAACADPQ8ZpJ9d5WDgEtb3BKJZMPz8enALw7/+E8hFcaXpeX6KfnuuwKSzlPi53yYfA2tXmDpN4t3lopXTVSiM9wR/PAtLz6gtmk+lysavGy+nbIFZppGGy/cg2WWWUetF4DkhO0niA39/wxXgZ5NPR4p5ixqznYVHHQrnCwKDzol3xw3lAI2GgfIehJRjtxLjXkMulDmCBFN3lhtKh+Wt0n870qBPki6sgN7Ykkpo+d+mtr0L2vzYfIP0DIyX4Zcu7EMvGS5de8TtHderuiyA1WrCf4k4+7uPwahtW3zg/zWG/uFc9z7eDkBzZgd0j6oU76FH48YO5rz5hwazUG7ubK2WodFlERIqViq0vt+zB7fVLQFSXoAk/f5QwvJkZsrKrnyTiHCLp7y55fXPkrTfcftHQDXsM/IdEa7GTyMMNWB+XuweWZrn76WaluoRbqnMvJabpAs3eYwZnoYRClWmZ4Yto34wA5QMYT9VvfrZmTa2zo+1rEoZzDQJCgZM0rHNjUWyfCATgfOOCLx51l14CvDT+JrGM3XzOTFRXcrnGws3PADMVO15KZ7lTnFktS+6gndEs9YBvlyrNUNJm7gVvLyvIxDbBOXTsHNaIY0lvygb+RzXotJWD25wvdvCcP0OIoahxqATSeCD+EEUF50nKb0v42IIJOGY3FsUwtCF3OcZIf',
	}


}
