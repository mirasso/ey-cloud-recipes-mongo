#
# Cookbook Name:: nginx-custom
# Recipe:: default
#

if ['app_master', 'app'].include? node[:instance_role]
  node[:engineyard][:environment][:apps].each do |app|
    cookbook_file 'custom.conf' do
      path "/etc/nginx/servers/#{app[:name]}/custom.conf"
      source 'custom.conf'
      owner node[:users][0][:username]
      group node[:users][0][:username]
      mode 0644
    end
    cookbook_file 'custom.ssl.conf' do
      path "/etc/nginx/servers/#{app[:name]}/custom.ssl.conf"
      source 'custom.conf'
      owner node[:users][0][:username]
      group node[:users][0][:username]
      mode 0644
    end
    cookbook_file 'comap.users' do
      path '/etc/nginx/servers/comap.users'
      source 'comap.users'
      owner node[:users][0][:username]
      group node[:users][0][:username]
      mode 0644
    end
    execute "sudo /etc/init.d/nginx reload"
  end
end
