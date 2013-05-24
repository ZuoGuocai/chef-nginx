def initialize(*args)
  super
  @action = :enable
end

action :enable do
  directory "#{node[:nginx][:doc_root] }/#{new_resource.name}" do
    owner 'nginx'
    group 'nginx'
  end

  template "/etc/nginx/vhosts.d/#{new_resource.name}.conf" do
    source "nginx/vhosts/#{new_resource.name}.conf.erb"
    mode 0644
    notifies :reload, 'service[nginx]'
  end
  new_resource.updated_by_last_action(true)
end

action :disable do
  file "/etc/nginx/vhosts.d/#{new_resource.name}.conf" do
    action :delete
    notifies :reload, 'service[nginx]'
  end
  new_resource.updated_by_last_action(true)
end
