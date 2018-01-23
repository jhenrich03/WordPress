class wordpress::db (

	$root_password, 
	$db_ip,     
	$db_name,       
	$db_user,      
	$db_password,  
	$db_tables,     
	$db_host,       
	$wp_user,       
	$db_phrase,   
	
) {
	
    class { 'mysql::server':
	
      root_password           => $root_password,
      remove_default_accounts => true,
	  override_options        => {
	    mysqld              => {
		  'bind-address'    => $db_ip,
		},
	  },
	
      databases => {
        $db_name => {
          ensure  => 'present',
          charset => 'utf8',
        },
      },

      users => {
        $db_user => {
          ensure        => 'present',
          password_hash =>  mysql_password($db_password),
        },
      },

      grants => {
        "${db_user}/${db_tables}" => {
          ensure     => 'present',
          options    => ['GRANT'],
          privileges => ['ALL'],
          table      => $db_tables,
          user       => $db_user,
        },
      },
    }
}