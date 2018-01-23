class wordpress::web (  

  $packages,
  $service_name

) {	 
  package { $packages:
    ensure => 'installed',
  }

  file { '/etc/apache2/apache2.conf':
    ensure  => 'file',
	content => file('wordpress/apache2.conf'),
    notify  => Service[$service_name],
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

  service { $service_name:
    ensure  => 'running',
    enable  => true,
    require => Package[$service_name],
  }

}