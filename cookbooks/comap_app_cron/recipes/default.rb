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

if instance_role?(:app_master)
  cron "create_daily_report" do
    minute '30'
    hour '1'
    user 'deploy'
    command 'nice php /data/comap/current/cli/create_daily_report.php > /data/comap/shared/log/daily_report.log 2>&1'
  end
end
