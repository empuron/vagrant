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
  command 'psql -c "CREATE DATABASE demo;"'
end

execute 'postgres_db_pre3' do
  command "sed -i 's/peer/trust/g; s/ident/trust/g' /var/lib/pgsql/data/pg_hba.conf"
end

execute 'postgres_db' do
  user "postgres"
  cwd '/vagrant'
  command 'psql demo < jb7_demo_Dump.sql >/dev/null'
end

execute 'postgres_db_end' do
  user 'postgres'
  command 'psql -c "GRANT ALL PRIVILEGES ON DATABASE demo to empuron;"'
end

execute 'postgres_restart' do
  user 'root'
  command 'service postgresql restart'
end

# --------------------------------------------
# VM Einstellungen
# --------------------------------------------
execute 'create_jb_dir' do
  command "mkdir /opt/jboss && chmod 777 /opt/jboss"
end

execute 'copy_jboss' do
  command 'cp -r /vagrant/jboss/* /opt/jboss'
end

execute 'copy_jboss_service' do
  user "root"
  command 'cp /vagrant/jboss.service /usr/lib/systemd/system/jboss.service'
end
# --------------------------------------------

execute 'change_opt' do
  command "chown -R empuron.empuron /opt/jboss"
end
# --------------------------------------------
