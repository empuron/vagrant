Vagrant.configure("2") do |config|

  config.vm.define "JBoss-VM" do |jb|
    jb.vm.box = "centos7.1"
    jb.vm.box_url = "https://github.com/CommanderK5/packer-centos-template/releases/download/0.7.1/vagrant-centos-7.1.box"
    jb.vm.network :private_network, :ip => "172.10.1.10"
    jb.vm.synced_folder ".", "/vagrant", disabled:true
    jb.vm.provision :shell, :inline => "echo root | passwd --stdin root"
    jb.vm.provision :shell, :inline => "localectl set-keymap de"

    jb.vm.provider :virtualbox do |jb_vb|
      jb_vb.name = "Solar-JBoss"
    end
  end
  
  config.vm.define "Liferay-VM" do |lr|
    lr.vm.box = "centos7.1"
    lr.vm.network :private_network, :ip => "172.10.1.11"
    lr.vm.network "forwarded_port", guest: 80, host: 7777
    lr.vm.synced_folder ".", "/vagrant", disabled:true
    lr.vm.provision :shell, :inline => "echo root | passwd --stdin root"
    lr.vm.provision :shell, :inline => "localectl set-keymap de"
    lr.vm.provision :shell, path: "start.sh"
    lr.vm.provision :file, source: "start.sls", destination: "/srv/salt/start.sls"
    lr.vm.provision :shell, :inline => "salt-call --local state.apply start >/dev/null"

    lr.vm.provider :virtualbox do |lr_vb|
      lr_vb.name = "Solar-Liferay"
    end
  end

end
