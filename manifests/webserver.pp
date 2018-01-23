include wordpress::config
include wordpress::web
include wordpress::install

host { "webserver":
	ensure  => "present",
	ip      => "172.31.0.11",
	}
	
host { "dbserver":
	ensure  => "present",
	ip      => "172.31.0.10",
	}