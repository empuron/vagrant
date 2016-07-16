Vagrant.configure("2") do |config|

  config.vm.define "T1" do |tm1|
    tm1.vm.box = "centos7.1"
    tm1.vm.box_url = "https://github.com/CommanderK5/packer-centos-template/releases/download/0.7.1/vagrant-centos-7.1.box"
    tm1.vm.network :private_network, :ip => "150.150.150.1"
    tm1.vm.synced_folder "./", "/vagrant", disabled:true
    tm1.vm.provision :shell, path: "start.sh"
    tm1.vm.provision :file, source: "start.sls", destination: "/srv/salt/start.sls"

    tm1.vm.provider :virtualbox do |tm1_vb|
      tm1_vb.name = "T1"
    end

    tm1.vm.provider :salt do |salt|
      salt.masterless = true
      salt.run_highstate = true
    end

    tm1.vm.post_up_message = "T1 ist nun bereit!"
  end

  config.vm.define "T2" do |tm2|
    tm2.vm.box = "centos7.1"
    tm2.vm.network :private_network, :ip => "150.150.150.2"
    tm2.vm.synced_folder "./", "/vagrant", disabled:true
    tm2.vm.provision :shell, path: "start.sh"
    tm2.vm.provision :file, source: "start.sls", destination: "/srv/salt/start.sls"

    tm2.vm.provider :virtualbox do |tm2_vb|
      tm2_vb.name = "T2"
    end

    tm2.vm.provider :salt do |salt|
      salt.masterless = true
      salt.run_highstate = true
    end

    tm2.vm.post_up_message = "T2 ist nun bereit!"
  end

end
