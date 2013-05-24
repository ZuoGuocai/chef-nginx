default[:nginx][:workers] = 1
default[:nginx][:worker_conns] = 1024
default[:nginx][:gzip] = 'on'
default[:nginx][:default_vhost][:enable] = true
default[:nginx][:doc_root] = '/var/www'
default[:nginx][:version] = '1.4.1'
