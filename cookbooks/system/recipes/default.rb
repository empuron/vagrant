#############################################################################
# Standard Installation #####################################################
#############################################################################
change_root_command = "echo root | passwd --stdin root"
change_keyboard_command = "localectl set-keymap de"

execute 'change_root' do
  command change_root_command
end

user 'empuron' do
  uid '1111'
  home '/home/empuron'
  shell '/bin/bash'
end

execute 'change_empuron' do
  command 'echo empuron | passwd --stdin empuron'
end

execute 'empuron_sudoers' do
  user 'root'
  command 'usermod -a -G wheel empuron'
end

execute 'change_keyboard' do
  command change_keyboard_command
end

execute 'java_copy' do
  command 'cp /vagrant/jdk-7u79-linux-x64.rpm /opt/jdk-7u79-linux-x64.rpm'
end

execute 'java_install' do
  command 'yum install -y /opt/jdk-7u79-linux-x64.rpm'
end

execute 'gcc_make_install' do
  user 'root'
  command 'yum install gcc make -y'
end
#############################################################################

#############################################################################
# PostgreSQL Installation ###################################################
#############################################################################
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

execute 'postgres_db_pre' do
  user 'postgres'
  command 'psql -c "CREATE USER empuron WITH PASSWORD \'root!\'";'
end

execute 'postgres_db_pre2' do
  command "sed -i 's/peer/trust/g; s/ident/trust/g' /var/lib/pgsql/data/pg_hba.conf"
end

execute 'postgres_restart' do
  user 'root'
  command 'service postgresql restart'
end
#############################################################################

#############################################################################
# Ruby Installation #########################################################
#############################################################################

execute 'ruby_download' do
  cwd '/opt'
  user 'root'
  command 'wget https://cache.ruby-lang.org/pub/ruby/2.3/ruby-2.3.1.tar.gz'
end

execute 'ruby_extract' do
  cwd '/opt'
  user 'root'
  command 'tar xvf ruby-2.3.1.tar.gz'
end

execute 'zlib_openssl-devel_install' do
  user 'root'
  command 'yum install -y zlib-devel openssl openssl-devel'
end

execute 'ruby_install' do
  cwd '/opt/ruby-2.3.1'
  user 'root'
  command './configure --with-openssl-dir=/usr/lib64/openssl && make && make install'
end

#############################################################################

#############################################################################
# InSpec Installation #######################################################
#############################################################################

execute 'inspec_install' do
  user 'root'
  command 'gem install inspec'
end

#############################################################################
