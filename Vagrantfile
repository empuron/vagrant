# Wichtig ist es "vagrant plugin install vagrant-vbguest" auszuführen
# An Variablen denken !!!
hallo = "Hallo"
Vagrant.configure("2") do |config|
  config.vm.define "JBoss-VM" do |jb|
    jb.vm.box = "centos7.1"
    jb.vm.box_url = jb.vm.box_url = "https://github.com/CommanderK5/packer-centos-template/releases/download/0.7.1/vagrant-centos-7.1.box"
    jb.vm.network :private_network, :ip => "192.168.111.11"
    jb.vm.synced_folder "./", "/vagrant", disabled:true
    jb.vm.provision :shell, :inline => "chmod -R 777 /opt"
    jb.vm.synced_folder "./Files", "/vagrant"

    jb.vm.provision :chef_solo do |jb_chef|
      jb_chef.channel = "stable"
      jb_chef.version = "12.10.24"
      jb_chef.add_recipe "system08"
    end

    jb.vm.provider :virtualbox do |jb_vb|
      jb_vb.name = "System08-JBoss"
    end
  end

  config.vm.define "Liferay-VM" do |lr|
    lr.vm.box = "centos7.1"
    lr.vm.network :private_network, :ip => "192.168.111.12"
    lr.vm.synced_folder "./", "/vagrant", disabled:true
    lr.vm.provision :shell, :inline => "chmod -R 777 /opt"
    lr.vm.synced_folder "./Files", "/vagrant"

    lr.vm.provision :chef_solo do |lr_chef|
      lr_chef.channel = "stable"
      lr_chef.version = "12.10.24"
      lr_chef.add_recipe "liferay"
    end

    lr.vm.provider :virtualbox do |lr_vb|
      lr_vb.name = "System08-Liferay"
    end
  end
end
