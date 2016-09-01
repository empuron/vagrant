#######################################
# Variablen ###########################
#######################################

# JBoss Ordner Elternverzeichnis
$jboss_folder_parent = 'opt'

# JBoss Ordner Name
$jboss_folder_name = 'jboss'

# Port auf dem JBoss hört
$jboss_port = '8080'

# Postgres Version
$postgres_version = '9.2'

# Port von Postgres Service
$postgres_port = '5432'

# Name der Datenbank
$database_name = 'demo'

# IP-Adressen von 158.226.194.0/24 Netzwerk
$ipArray = ['32','42', '190']

# Linux besitzt meistens unterschiedliche Namen
# für die NIC Karten
$interfaces = ['eno1', 'enp0s3']

# System Lokal bei Empuron ?
$system_local = true

#######################################

#######################################
# Funktionen ##########################
#######################################

# -- Überprüfe Interfaces -- #

# Existiert das Interface und Ist
# es aktiviert
# Überprüfe Speed von Interface

def check_interface
    $interfaces.each do |element|
      describe interface(element) do
        it { should exist }
        it { should be_up }
        its(:speed) { should eq 100 }
      end
    end
end


# -- Überprüfe IP-Verbindungen -- #

def check_ip_connection

  if $system_local
    # Einfacher IP Check für wichtige Server
    $ipArray.each do |ip|
      describe host("158.226.194.#{ip}") do
        it { should be_reachable }
      end
    end

    # Wird die Firewall erreicht, auch unter Namen
    describe host('pfsense.empuron') do
      its(:ipaddress) { should include '158.226.194.42'}
    end
  end
end


# -- Überprüfe JBoss -- #

def check_jboss
  # Ist der JBoss Ordner vorhanden
  describe command("ls #{$jboss_folder_parent}") do
    its(:stdout) { should match $jboss_folder_name }
  end

  # Ist dieser Port aktiviert
  describe port($jboss_port) do
    it { should be_listening }
  end

  # Überprüfe Eigenschaften von JBoss Ordner in /opt
  describe file("/#{$jboss_folder_parent}/#{$jboss_folder_name}") do
    it { should be_directory }
    it { should be_owned_by 'empuron' }
  end

  # Ist die richtige Datenbank in die standalone.xml eingetragen
  describe file("/#{$jboss_folder_parent}/#{$jboss_folder_name}/standalone/configuration/standalone.xml") do
    its(:content) { should match "jdbc:postgresql://localhost:#{$postgres_port}/#{$database_name}" }
  end
end

#######################################

# Ist die richtige Postgres Version installiert
describe command('psql --version') do
  its(:stdout) { should match $postgres_version }
end

# Wird der SSH Daemon beim Booten
# gestartet und ist er momentan am laufen
describe service('sshd') do
  it { should be_enabled }
  it { should be_running }
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

check_interface
check_ip_connection
check_jboss
