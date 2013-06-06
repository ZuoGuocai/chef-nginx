nginx Cookbook
==============

Manages Nginx on RHEL/Centos.

Requirements
------------

* the **yum** cookbook

Attributes
----------

    default['nginx']['workers'] = 1
    default['nginx']['worker_conns'] = 1024
    default['nginx']['gzip'] = 'on'
    default['nginx']['default_vhost']['enable'] = true
    default['nginx']['doc_root'] = '/var/www'

Usage
-----

Add your template for site www.example.com under your cookbook's template directory, under nginx/vhost.

Example: $cookbook/templates/defaults/nginx/vhosts/www.example.com.conf.erb

Use the following LWRP

    nginx_vhost 'www.example.com' do
    end

Creates the document root, adds the vhost configuration under /etc/nginx/vhosts.d/www.example.com.conf then reloads Nginx.

Contributing
------------

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write you change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors: Jean-Francois Theroux <failshell@gmail.com>
License: Apache 2.0
