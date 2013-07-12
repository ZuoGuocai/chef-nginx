#
# Cookbook Name:: nginx
# Recipe:: modsecurity
#
# Copyright 2013, Jean-Francois Theroux
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Intercepted files
directory node[:nginx][:modsecurity][:SecUploadDir] do
  recursive true
  owner 'nginx'
  group 'root'
  mode 0750
end

# Audit logs
directory node[:nginx][:modsecurity][:SecAuditLogStorageDir] do
  recursive true
  owner 'nginx'
  group 'root'
  mode 0750
end

# GeoLiteCity
# FIXME: add a mechanism to download on a frequency
remote_file '/var/lib/modsecurity/GeoLiteCity.dat.gz' do
  owner 'nginx'
  group 'root'
  mode 0640
  source 'http://geolite.maxmind.com/download/geoip/database/GeoLiteCity.dat.gz'
  not_if { File.exists?('/var/lib/modsecurity/GeoLiteCity.dat.gz') }
end

execute 'decompress geolitecity' do
  command 'gzip -fd /var/lib/modsecurity/GeoLiteCity.dat.gz'
  only_if { File.exists?('/var/lib/modsecurity/GeoLiteCity.dat.gz') }
end

# CRS 
template '/etc/nginx/modsecurity.d/modsecurity_crs_10_setup.conf' do
  mode 0640
  notifies :restart, 'service[nginx]'
end

package 'git'

git '/etc/nginx/modsecurity.d' do
  repository node[:nginx][:modsecurity][:crs][:repo]
  reference node[:nginx][:modsecurity][:crs][:version]
end

# Use all base rules
ruby_block 'symlink all base rules' do
  block do
    Dir.entries('/etc/nginx/modsecurity.d/base_rules/').each do |f|
      link "/etc/nginx/modsecurity.d/activated_rules/#{f}" do
        to "/etc/nginx/modsecurity.d/base_rules/#{f}"
        notifies :restart, 'service[nginx]'
        only_if { f =~ /\.(conf|data)$/ }
      end
    end
  end
end

# its too bad they all use different naming conventions..
# optional rules
node[:nginx][:modsecurity][:crs][:optional_rules].each do |r|
  link "/etc/nginx/modsecurity.d/activated_rules/#{r}.conf" do
    to "/etc/nginx/modsecurity.d/optional_rules/#{r}.conf"
    notifies :restart, 'service[nginx]'
  end
  link "/etc/nginx/modsecurity.d/activated_rules/#{r.gsub(/_crs/, '')}.data" do
    to "/etc/nginx/modsecurity.d/optional_rules/#{r.gsub(/_crs/, '')}.data"
    notifies :restart, 'service[nginx]'
    only_if { File.exists?("/etc/nginx/modsecurity.d/optional_rules/#{r.gsub(/_crs/, '')}.data") }
  end
end

# slr rules
node[:nginx][:modsecurity][:crs][:slr_rules].each do |r|
  link "/etc/nginx/modsecurity.d/activated_rules/#{r}.conf" do
    to "/etc/nginx/modsecurity.d/slr_rules/#{r}.conf"
    notifies :restart, 'service[nginx]'
  end
  link "/etc/nginx/modsecurity.d/activated_rules/#{r.gsub(/_crs/, '').gsub(/_attacks/, '')}.data" do
    to "/etc/nginx/modsecurity.d/slr_rules/#{r.gsub(/_crs/, '').gsub(/_attacks/, '')}.data"
    notifies :restart, 'service[nginx]'
    only_if { File.exists?("/etc/nginx/modsecurity.d/slr_rules/#{r.gsub(/_crs/, '').gsub(/_attacks/, '')}.data") }
  end
end

# experimental rules
node[:nginx][:modsecurity][:crs][:experimental_rules].each do |r|
  link "/etc/nginx/modsecurity.d/activated_rules/#{r}.conf" do
    to "/etc/nginx/modsecurity.d/experimental_rules/#{r}.conf"
    notifies :restart, 'service[nginx]'
  end
end
