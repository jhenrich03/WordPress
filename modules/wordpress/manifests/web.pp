class wordpress::web {

  $packages = "${facts['os']['distro']['codename']}" ? {
	   'trusty' => [ 'php5', 'libapache2-mod-php5', 'php5-mysql', 'apache2', 'phpmyadmin', 'php5-mcrypt', ],
	   'xenial' => [ 'php', 'libapache2-mod-php', 'php-mysql', 'apache2', 'phpmyadmin', ],
	   default  => [ 'apache2', 'phpmyadmin' ],
	   }

  package { $packages:
    ensure => 'installed',
  }

  file { '/etc/apache2/apache2.conf':
    ensure  => 'file',
	content => file('wordpress/apache2.conf'),
    notify  => Service['apache2'],
  }

  file { '/etc/apache2/mods-enabled/dir.conf':
    ensure  => 'file',
    content => file('wordpress/dir.conf'),
    notify  => Service['apache2'],
  }

  file { '/etc/phpmyadmin/config.inc.php':
	ensure  => 'file',
	content => epp('wordpress/config.inc.epp'),
  }
  
  file { '/etc/phpmyadmin/config-db.php':
	ensure  => 'file',
	content => "",
  }

  service { 'apache2':
    ensure  => 'running',
    enable  => true,
    require => Package['apache2'],
  }

}