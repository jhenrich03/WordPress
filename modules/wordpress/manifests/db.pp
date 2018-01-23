class wordpress::db {

    class { 'mysql::server':
	
      root_password           => $wordpress::config::root_password,
      remove_default_accounts => true,
	  override_options        => {
	    mysqld              => {
		  'bind-address'    => $wordpress::config::db_ip,
		},
	  },
	
      databases => {
        $wordpress::config::db_name => {
          ensure  => 'present',
          charset => 'utf8',
        },
      },

      users => {
        $wordpress::config::db_user => {
          ensure        => 'present',
          password_hash =>  mysql_password($wordpress::config::db_password),
        },
      },

      grants => {
        "${wordpress::config::db_user}/${wordpress::config::db_tables}"   => {
          ensure     => 'present',
          options    => ['GRANT'],
          privileges => ['ALL'],
          table      => $wordpress::config::db_tables,
          user       => $wordpress::config::db_user,
        },
      },
    }
}