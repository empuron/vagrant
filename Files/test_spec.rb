jboss_folder_name = 'jboss'
jboss_port = '8080'
postgres_version = '9.2'
postgres_port = '5432'
database_name = 'demo'

# Ist der Apache Web Server installiert
#describe package('httpd'), :if => os[:family] == 'redhat' do
#  it { should be_installed }
#end

# Ist dieser Port aktiviert
#describe port(jboss_port) do
#  it { should be_listening }
#end

# Ist der JBoss Ordner vorhanden
describe command('ls /opt') do
  its(:stdout) { should match jboss_folder_name }
end

# Ist die richtige Postgres Version installiert
describe command('psql --version') do
  its(:stdout) { should match postgres_version }
end

# Ist die richtige Datenbank in die standalone.xml eingetragen
describe file("/opt/#{jboss_folder_name}/standalone/configuration/standalone.xml") do
  its(:content) { should match "jdbc:postgresql://localhost:#{postgres_port}/#{database_name}" }
end

# Überprüfe Eigenschaften von JBoss Ordner in /opt
describe file('/opt/jboss') do
  it { should be_directory }
  it { should be_owned_by 'empuron' }
end

meinArray = ['32','42', '190']

# Einfacher IP Check für wichtige Server
meinArray.each do |ip|
  describe host("158.226.194.#{ip}") do
    it { should be_reachable }
  end
end

# Wird die Firewall erreicht, auch unter Namen
describe host('pfsense.empuron') do
  its(:ipaddress) { should include '158.226.194.42'}
end

# Wird der SSH Daemon beim Booten
# gestartet und ist er momentan am laufen
describe service('sshd') do
  it { should be_enabled }
  it { should be_running }
end

# Existiert das Interface und Ist
# es aktiviert
# Überprüfe Speed von Interface
describe.one do
  describe interface("eno1") do
    it { should exist }
    it { should be_up }
    its(:speed) { should eq 1000 }
  end

  describe interface("enp0s3") do
    it { should exist }
    it { should be_up }
    its(:speed) { should eq 1000 }
  end
end

# Kann ich das Internet erreichen und mittels
# DNS den Namen auflösen
describe host('www.google.de') do
  it { should be_resolvable }
end

# Kann sich der Benutzer anmelden (auf Bash)
describe user('empuron') do
  its(:shell) { should eq '/bin/bash' }
end

ruby_path = '/usr/local/bin/ruby'

# Ist Ruby installiert
if describe command(ruby_path).exist?
   describe command(ruby_path) do
     its(:stdout) { should eq '' }
   end
end
