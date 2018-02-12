class wordpress::install {

  $wordpress_file = "latest.tar.gz"

  file { "/usr/local/${wordpress_file}":
	ensure  => "present",
    	source  => "http://wordpress.org/${wordpress_file}",
	replace => "false",
  }

  exec { "Extract":
    command => "tar -xzf /usr/local/${wordpress_file} -C /",
    creates => "/wordpress",
    path    => "/bin",
    require => File["/usr/local/${wordpress_file}"],
  }

  exec { "Copy":
    command => "cp -r /wordpress/* /var/www/html",
    creates => "/var/www/html/index.php",
    path    => "/bin",
    require => Exec["Extract"],
  }

  file { "/var/www/html/wp-config.php":
    ensure  => "file",
    content => epp("wordpress/wp-config.epp"),
    require => Exec["Copy"],
    mode    => "0664",
  }

  file { "/var/www/html":
    ensure  => "directory",
    group   => "www-data",
    mode    => "0664",
    recurse => true,
    require => File["/var/www/html/wp-config.php"],
  }
}
