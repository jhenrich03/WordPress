class wordpress {

include wordpress::config

include wordpress::db

class { 'wordpress::web':
  require => Class['wordpress::db'],
  }

class { 'wordpress::install':
  require => Class['wordpress::web'],
  }

}