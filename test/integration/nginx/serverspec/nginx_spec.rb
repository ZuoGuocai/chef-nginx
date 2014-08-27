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
    '/var/www' => { 'owner' => 'nginx', 'group' => 'nginx', 'mode' =>  755 },
    '/var/log/nginx' => { 'owner' => 'nginx', 'group' => 'nginx', 'mode' =>  750 }
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
    '/etc/nginx/nginx.conf' => { 'owner' => 'root', 'group' => 'root', 'mode' => 644 }
  }

  files.each do |f, attr|
    it "Creates the #{f} file" do
      expect(file f).to be_file
      expect(file f).to be_mode attr['mode']
      expect(file f).to be_owned_by attr['owner']
      expect(file f).to be_grouped_into attr['group']
    end
  end

  # nginx service
  it 'Enables and starts nginx' do
    expect(service 'nginx').to be_enabled
    expect(service 'nginx').to be_running
  end
end
