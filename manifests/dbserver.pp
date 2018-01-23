include wordpress::config
include wordpress::db

host { "webserver":
	ensure  => "present",
	ip      => "172.31.0.11",
	}
	
host { "dbserver":
	ensure  => "present",
	ip      => "172.31.0.10",
	}