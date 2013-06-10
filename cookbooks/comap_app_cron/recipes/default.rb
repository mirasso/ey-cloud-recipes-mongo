#
# Cookbook Name:: comap_app_cron
# Recipe:: default
#

if instance_role?(:app_master, :app, :solo)
  cron "remove_uploaded_photo_files" do
    minute '*/10'
    user 'deploy'
    command 'nice find /data/comap/shared/tmp/ -amin +10 -type f | xargs rm -f > /dev/null 2>&1'
  end
end
