# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

  config.vm.box = "ubuntu/trusty64"
  config.vm.provision "shell", path: "scripts/install.sh"
  
  
  #define the database server & provision with puppet
  config.vm.define "db" do |db| 
    db.vm.hostname = "dbserver" 
    db.vm.network "private_network", ip: "172.31.0.10"
	db.vm.provision "puppet" do |puppet|
	  puppet.module_path = "modules"
	  puppet.manifest_file = "dbserver.pp"
	  puppet.hiera_config_path = "hiera.yaml"
	  #puppet.options = "--verbose --debug"
	  end
  end
  
  #define the web server & provision with puppet
  config.vm.define "web" do |web| 
    web.vm.hostname = "webserver" 
    web.vm.network "private_network", ip: "172.31.0.11"
	web.vm.network "forwarded_port", guest: 80, host: 4567, auto_correct: true 
	web.vm.provision "puppet" do |puppet|
	  puppet.module_path = "modules"
	  puppet.manifest_file = "webserver.pp"
	  puppet.hiera_config_path = "hiera.yaml"
	  #puppet.options = "--verbose --debug"
	  end
  end 
end
