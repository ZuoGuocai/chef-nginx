require 'spec_helper'

describe 'nginx' do
  # failshell yum repo
  it 'Creates the failshell yum repo' do
    expect(yumrepo 'failshell').to exist
    expect(yumrepo 'failshell').to be_enabled
  end

  # nginx package
  it 'Installs the package nginx' do
    expect(package 'nginx').to be_installed.with_version('1.7.1-5.el6.modsec')
  end

  # directories
  directories = {
    '/etc/nginx/vhosts.d' => { 'owner' => 'root', 'group' => 'root', 'mode' =>  750 },
    '/etc/nginx/ssl' => { 'owner' => 'root', 'group' => 'root', 'mode' =>  750 },
    '/etc/nginx/modsecurity.d' => { 'owner' => 'root', 'group' => 'root', 'mode' =>  755 },
    '/var/www' => { 'owner' => 'nginx', 'group' => 'nginx', 'mode' =>  755 },
    '/var/log/nginx' => { 'owner' => 'nginx', 'group' => 'nginx', 'mode' =>  750 },
    '/var/lib/modsecurity/upload' => { 'owner' => 'nginx', 'group' => 'root', 'mode' =>  750 },
    '/var/lib/modsecurity/audit' => { 'owner' => 'nginx', 'group' => 'root', 'mode' =>  750 }
  }

  directories.each do |dir, attr|
    it "Creates the #{dir} directory" do
      expect(file dir).to be_directory
      expect(file dir).to be_mode attr['mode']
      expect(file dir).to be_owned_by attr['owner']
      expect(file dir).to be_grouped_into attr['group']
    end
  end

  # files
  files = {
    '/etc/nginx/nginx.conf' => { 'owner' => 'root', 'group' => 'root', 'mode' => 644 },
    '/etc/nginx/modsecurity.conf' => { 'owner' => 'nginx', 'group' => 'root', 'mode' => 640 },
    '/etc/nginx/modsecurity.d/modsecurity_crs_10_setup.conf' => { 'owner' => 'root', 'group' => 'root', 'mode' => 640 },
    '/var/lib/modsecurity/GeoLiteCity.dat' => { 'owner' => 'nginx', 'group' => 'root', 'mode' => 640 }
  }

  files.each do |f, attr|
    it "Creates the #{f} file" do
      expect(file f).to be_file
      expect(file f).to be_mode attr['mode']
      expect(file f).to be_owned_by attr['owner']
      expect(file f).to be_grouped_into attr['group']
    end
  end

  # modsec rules symlinks
  rules = [
    'modsecurity_35_bad_robots.data',
    'modsecurity_35_scanners.data',
    'modsecurity_40_generic_attacks.data',
    'modsecurity_50_outbound.data',
    'modsecurity_50_outbound_malware.data',
    'modsecurity_crs_20_protocol_violations.conf',
    'modsecurity_crs_21_protocol_anomalies.conf',
    'modsecurity_crs_23_request_limits.conf',
    'modsecurity_crs_30_http_policy.conf',
    'modsecurity_crs_35_bad_robots.conf',
    'modsecurity_crs_40_generic_attacks.conf',
    'modsecurity_crs_41_sql_injection_attacks.conf',
    'modsecurity_crs_41_xss_attacks.conf',
    'modsecurity_crs_42_tight_security.conf',
    'modsecurity_crs_45_trojans.conf',
    'modsecurity_crs_47_common_exceptions.conf',
    'modsecurity_crs_49_inbound_blocking.conf',
    'modsecurity_crs_50_outbound.conf',
    'modsecurity_crs_59_outbound_blocking.conf',
    'modsecurity_crs_60_correlation.conf'
  ]

  rules.each do |rule|
    deactivated = "/etc/nginx/modsecurity.d/base_rules/#{rule}"
    it "Creates the #{rule} rule file" do
      expect(file deactivated).to be_file
      expect(file deactivated).to be_mode 644
      expect(file deactivated).to be_owned_by 'root'
      expect(file deactivated).to be_grouped_into 'root'
    end

    activated = "/etc/nginx/modsecurity.d/activated_rules/#{rule}"
    it "Activates the #{rule} rule" do
      expect(file activated).to be_linked_to deactivated
    end
  end

  # nginx service
  it 'Enables and starts nginx' do
    expect(service 'nginx').to be_enabled
    expect(service 'nginx').to be_running
  end

  # SSL configuration
  it 'Has the proper SSL protocols enabled' do
    expect(file '/etc/nginx/nginx.conf').to contain 'ssl_protocols TLSv1 TLSv1.1 TLSv1.2;'
  end
end
