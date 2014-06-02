Vagrant.configure("2") do |config|
  config.vm.hostname = "nginx-berkshelf"
  config.vm.box = "opscode-centos-6.5"
  config.vm.box_url = "http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_centos-6.5_chef-provisionerless.box"
  config.berkshelf.enabled = true
  config.omnibus.chef_version = :latest
  config.vm.network :forwarded_port, guest: 80, host: 8080

  config.vm.provision :chef_solo do |chef|
    chef.json = {
      "nginx" => {
        "version" => "1.7.1-5.el6.modsec",
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
