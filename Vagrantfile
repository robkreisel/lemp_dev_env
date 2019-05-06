# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.box = "ubuntu/xenial32"

  config.vm.network "forwarded_port", guest: 80, host: 80

  config.vm.network "private_network", ip: "10.10.10.10"

  config.vm.synced_folder "./", "/var/www", create: true, group: "www-data", owner: "www-data"

  config.vm.provision "shell" do |s|
    s.path = "provision.sh"
  end

end
