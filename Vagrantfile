# Wichtig ist es "vagrant plugin install vagrant-vbguest" auszuführen
# An Variablen denken !!!
version = "System-08"
Vagrant.configure("2") do |config|
  config.vm.define version do |s8|
    s8.vm.box = "centos7.1"
    s8.vm.box_url = "https://github.com/CommanderK5/packer-centos-template/releases/download/0.7.1/vagrant-centos-7.1.box"
    s8.vm.network :private_network, :ip => "192.168.111.11"
    s8.vm.synced_folder "./", "/vagrant", disabled:true
    s8.vm.provision :shell, :inline => "chmod -R 777 /opt"
    s8.vm.synced_folder "./Files", "/vagrant"

    s8.vm.provision :chef_solo do |sys_chef|
      sys_chef.channel = "stable"
      sys_chef.version = "12.10.24"
      sys_chef.add_recipe "system"
    end

    s8.vm.provision :chef_solo do |jb_chef|
      jb_chef.channel = "stable"
      jb_chef.version = "12.10.24"
      jb_chef.add_recipe "jboss"
    end

    s8.vm.provision :chef_solo do |lr_chef|
      lr_chef.channel = "stable"
      lr_chef.version = "12.10.24"
      lr_chef.add_recipe "liferay"
    end

    s8.vm.provider :virtualbox do |s8_vb|
      s8_vb.name = "System08-JBoss"
    end
  end

end
