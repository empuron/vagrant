# --------------------------------------------
# Standard Einstellungen
# --------------------------------------------
change_root_command = "echo root | passwd --stdin root"
change_keyboard_command = "localectl set-keymap de"

execute 'change_root_password' do
  command change_root_command
end

user 'empuron' do
  uid '1111'
  home '/home/empuron'
  shell '/bin/bash'
end

execute 'change_empuron_password' do
  command 'echo empuron | passwd --stdin empuron'
end

execute 'change_keyboard' do
  command change_keyboard_command
end

execute 'copy_java' do
  command 'cp /vagrant/jdk-7u79-linux-x64.rpm /opt/jdk-7u79-linux-x64.rpm'
end

execute 'install_java' do
  command 'yum install -y /opt/jdk-7u79-linux-x64.rpm'
end

package 'postgresql' do
  action :install
end

package 'postgresql-server' do
  action :install
end

execute 'postgresql_init' do
  command 'postgresql-setup initdb'
end

service 'postgresql' do
  action [:enable, :start]
end

execute 'postgres_db_pre1' do
  user 'postgres'
  command 'psql -c "CREATE USER empuron WITH PASSWORD \'root!\'";'
end

execute 'postgres_db_pre2' do
  user 'postgres'
  command 'psql -c "CREATE DATABASE liferay;"'
end

execute 'postgres_db_pre3' do
  user 'postgres'
  command 'psql -c "GRANT ALL PRIVILEGES ON DATABASE liferay to empuron;"'
end

execute 'postgres_db' do
  user 'postgres'
  cwd '/vagrant'
  command 'echo "Datenbank wird eingespielt..." && psql -U empuron liferay < jb7_liferay_Dump.sql >/dev/null && echo "Datenbank wurde vollständig eingespielt"'
end

# --------------------------------------------

# --------------------------------------------
# VM Einstellungen
# --------------------------------------------
execute 'create_lr_dir' do
  command "mkdir /opt/liferay && chmod 777 /opt/liferay"
end

execute 'copy_liferay' do
  command 'cp -r /vagrant/liferay/* /opt/liferay'
end

execute 'copy_liferay_service' do
  user "root"
  command 'cp /vagrant/liferay.service /usr/lib/systemd/system/liferay.service'
end
# --------------------------------------------

execute 'change_opt' do
  command "chown -R empuron.empuron /opt/liferay"
end
