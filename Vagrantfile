# -*- mode: ruby -*-
Vagrant.configure("2") do |config|
  # box
  config.vm.box = "bento/ubuntu-18.04"
  # network
  config.vm.network "private_network", ip: "192.168.33.254"
  config.vm.network "public_network" , bridge: "en0: Wi-Fi (AirPort)"
  # mount
  config.vm.synced_folder ".", "/home/vagrant/work"
  # memory
  config.vm.provider "virtualbox" do |vb|
    vb.gui = false
    vb.memory = "2048"
    vb.customize ["modifyvm", :id, "--natdnsproxy1", "off"]
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "off"]
  end
end
