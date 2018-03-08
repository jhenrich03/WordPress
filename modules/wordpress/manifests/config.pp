class wordpress::config {
      $db_name          = 'wordpress-db'
      $db_user          = 'wordpress@%'
      $wp_user          = 'wordpress'
      $db_password      = 'wordpress'
      $db_host          = 'dbserver'
      $db_phrase        = 'testphrase'
      $root_password    = 'bk3qql'
      $db_perms         = 'ALL'
      $db_tables        = "${db_name}.*"
      $db_ip            = '172.31.0.10'	  
}
