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
    }

    chef.run_list = [
        "recipe[minitest-handler::default]",
        "recipe[nginx::default]"
    ]
  end
end
