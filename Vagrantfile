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
    }

    chef.run_list = [
        "recipe[minitest-handler::default]",
        "recipe[nginx::default]"
    ]
  end
end
