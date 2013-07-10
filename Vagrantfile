<<<<<<< HEAD
Vagrant.configure("2") do |config|
  config.vm.hostname = "nginx-berkshelf"
  config.vm.box = "centos64-64-chef11"
  config.vm.box_url = "http://static.theroux.ca/vagrant/boxes/centos64-64-chef11.box"
  config.ssh.max_tries = 40
  config.ssh.timeout   = 120
  config.berkshelf.enabled = true
  config.vm.network :forwarded_port, guest: 80, host: 8080

  config.vm.provision :chef_solo do |chef|
    chef.json = {
      "nginx" => {
        "modsecurity" => {
          "enable" => true
        }
      }
=======
# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.hostname = "nginx-berkshelf"
  config.vm.box = "centos64-64"
  config.vm.box_url = "http://static.theroux.ca/vagrant/boxes/centos64-64.box"
  config.vm.network :private_network, ip: "33.33.33.122"
  config.ssh.max_tries = 40
  config.ssh.timeout   = 120
  config.berkshelf.enabled = true

  config.vm.provision :chef_solo do |chef|
    chef.json = {
>>>>>>> 49cf256a8c5abf1758b12311294289d3502b6e59
    }

    chef.run_list = [
        "recipe[minitest-handler::default]",
        "recipe[nginx::default]"
    ]
  end
end
