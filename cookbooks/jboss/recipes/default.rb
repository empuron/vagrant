# --------------------------------------------
# JBoss Einstellungen
# --------------------------------------------

execute 'postgres_db_pre_jb' do
  user 'postgres'
  command 'psql -c "CREATE DATABASE demo;"'
end

execute 'postgres_db_jb' do
  user 'root'
  cwd '/vagrant'
  command 'echo "Datenbank demo wird installiert..." && psql -U empuron demo < jb7_demo_Dump.sql >/dev/null && echo "Datenbank demo wurde erfolgreich installiert"'
end

execute 'postgres_db_jb_priv' do
  user 'postgres'
  command 'psql -c "GRANT ALL PRIVILEGES ON DATABASE demo TO empuron;"'
end

#execute 'postgres_db_jb_tables' do
# command 'GRANT ALL PRIVILEGES ON TABLE demo TO empuron;'
#end

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

execute 'change_opt' do
  command "chown -R empuron.empuron /opt/jboss && chmod -R 755 /opt/jboss"
end
# --------------------------------------------
