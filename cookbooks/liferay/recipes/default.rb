# --------------------------------------------
# Liferay Einstellungen
# --------------------------------------------

execute 'postgres_db_pre_lr' do
  user 'postgres'
  command 'psql -c "CREATE DATABASE liferay;"'
end

execute 'postgres_db_lr' do
  user "postgres"
  cwd '/vagrant'
  command 'echo "Datenbank liferay wird installiert..." && psql liferay < jb7_liferay_Dump.sql >/dev/null && echo "Datenbank liferay wurde erfolgreich installiert"'
end

execute 'postgres_db_lr_priv' do
  user 'postgres'
  command 'psql -c "GRANT ALL PRIVILEGES ON DATABASE liferay to empuron;"'
end

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

execute 'change_opt' do
  command "chown -R empuron.empuron /opt/liferay"
end
# --------------------------------------------
