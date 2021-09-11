class webserver::parameters {
	if $::osfamily == 'RedHat' {

		$packagename  = 'httpd'
		$configfile   = '/etc/httpd/conf/httpd.conf'
		$configsource = 'puppet:///modules/webserver/httpd.conf'
		$vhostfile    = '/etc/httpd/conf.d/vhost.conf'
		$defindex     = '/var/www/html/index.html'
		$defindexsrc  = 'puppet:///modules/webserver/index.html'
	
	} elsif $::osfamily == 'Debian' {

		$packagename  = 'apache2' 
		$configfile   = '/etc/apache2/apache2.conf'
		$configsource = 'puppet:///modules/webserver/apache2.conf'
		$vhostfile    = '/etc/apache2/sites-enabled/000-default.conf'
		$defindex     = '/var/www/html/index.html'
		$defindexsrc  = 'puppet:///modules/webserver/index.html'

	} else {
	}
}
