#
# Cookbook Name:: nginx
# Recipe:: default
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

if node[:platform_family] == 'rhel'
  include_recipe 'yum'

  yum_repository 'failshell' do
    name 'failshell'
    description 'Packages built by Jean-Francois Theroux'
    url 'http://static.theroux.ca/repository/el/6/$basearch'
    only_if { node[:nginx][:configure][:repo] == true }
  end

  package 'nginx' do
    version node[:nginx][:version]
  end

  # Clean up distrib examples. Move default site
  # to /etc/nginx/vhosts.d
  file '/etc/nginx/conf.d/example_ssl.conf' do
    action :delete
  end

  file '/etc/nginx/conf.d/default.conf' do
    action :delete
  end

  # Vhosts directory
  directory '/etc/nginx/vhosts.d' do
    mode 0750
  end

  template '/etc/nginx/nginx.conf' do
    mode 0644
    notifies :restart, 'service[nginx]'
  end

  # Doc root
  directory node[:nginx][:doc_root] do
    owner 'nginx'
    group 'nginx'
  end

  # SSL
  directory '/etc/nginx/ssl' do
    mode 0750
  end

  # Default vhost
  nginx_vhost 'default' do
    if node[:nginx][:default_vhost][:enable] == true
      action :enable
    else
      action :disable
    end
  end

  service 'nginx' do
    action [ :start, :enable ]
  end

  if node[:nginx][:modsecurity][:crs][:enable] == true
    include_recipe 'nginx::modsecurity'
  end

else
  log('Your distribution is not supported.')
end
