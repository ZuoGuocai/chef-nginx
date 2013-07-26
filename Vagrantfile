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
          "crs" => {
            "optional_rules" => [ "modsecurity_crs_46_av_scanning", "modsecurity_crs_42_comment_spam" ],
            "slr_rules" => [ "modsecurity_crs_46_slr_et_rfi_attacks", "modsecurity_crs_46_slr_et_sqli_attacks" ],
            "experimental_rules" => [ "modsecurity_crs_40_http_parameter_pollution" ]
          }
        }
      }
    }

    chef.run_list = [
        "recipe[minitest-handler::default]",
        "recipe[nginx::default]"
    ]
  end
end
