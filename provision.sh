#!/bin/bash

sudo -u vagrant cp /vagrant/.personal_ansible_vm.yml /home/vagrant/
sudo sed -i 's|http://us.|http://lt.|g' /etc/apt/sources.list

sudo ex +"%s@DPkg@//DPkg" -cwq /etc/apt/apt.conf.d/70debconf
sudo dpkg-reconfigure debconf -f noninteractive -p critical

sudo apt-get update >/dev/null
sudo apt-get install -y lxc vim mc htop ansible>/dev/null

[ -f /home/vagrant/.bash_aliases ] || sudo -u vagrant cp /vagrant/bash_aliases /home/vagrant/.bash_aliases
[ -f /home/vagrant/.bash_functions ] || sudo -u vagrant cp /vagrant/bash_functions /home/vagrant/.bash_functions
[ -f /home/vagrant/.vagrant_aliases ] || sudo -u vagrant cp /vagrant/vagrant_aliases /home/vagrant/.vagrant_aliases

[ -f /usr/bin/vagrant ] || cp /vagrant/vagrant_1.8.1_x86_64.deb ./ || wget https://releases.hashicorp.com/vagrant/1.8.1/vagrant_1.8.1_x86_64.deb
[ -f /usr/bin/vagrant ] || sudo dpkg -i vagrant_1.8.1_x86_64.deb

[ -d /home/vagrant/.vagrant.d/ ] || HOME=/home/vagrant sudo -u vagrant vagrant plugin list

[ -f /home/vagrant/.vagrant.d/Vagrantfile ] || sudo -u vagrant cp /vagrant/global_vagrant_file /home/vagrant/.vagrant.d/Vagrantfile

[ -d /home/vagrant/.vagrant.d/gems/gems/vagrant-lxc-1.2.1 ] || sudo -u vagrant tar zxf /vagrant/gems.tar.gz -C /home/vagrant/.vagrant.d/ || HOME=/home/vagrant sudo -u vagrant vagrant plugin install vagrant-lxc --plugin-version=1.2.1
[ -d /home/vagrant/.vagrant.d/gems/gems/vagrant-hostmanager-1.8.1 ] || sudo -u vagrant tar zxf /vagrant/gems.tar.gz -C /home/vagrant/.vagrant.d/ || HOME=/home/vagrant sudo -u vagrant vagrant plugin install vagrant-hostmanager --plugin-version=1.8.1
[ -d /home/vagrant/.vagrant.d/gems/gems/vagrant-triggers-0.5.3 ] || sudo -u vagrant tar zxf /vagrant/gems.tar.gz -C /home/vagrant/.vagrant.d/ || HOME=/home/vagrant sudo -u vagrant vagrant plugin install vagrant-triggers --plugin-version=0.5.3
[ -f /home/vagrant/.vagrant.d/plugins.json ] || sudo -u vagrant cp /vagrant/plugins.json /home/vagrant/.vagrant.d/plugins.json
[ -d /home/vagrant/.vagrant.d/boxes/oxid_esales-VAGRANTSLASH-trusty64-lxc/0/lxc ] || HOME=/home/vagrant sudo -u vagrant vagrant box add /vagrant/lxc.box --name=oxid_esales/trusty64-lxc

sudo patch /etc/default/lxc /vagrant/default.lxc.patch
sudo cp /vagrant/lxc-dnsmasq.conf /etc/lxc/dnsmasq.conf
sudo service lxc-net restart

sudo mkdir -p /volume
sudo bash -c "echo 192.168.33.1:/Users/oxid/vms/lxc /volume nfs rw,relatime,vers=3,rsize=8192,wsize=8192,namlen=255,hard,proto=udp,timeo=11,retrans=3,sec=sys,mountaddr=192.168.33.1,mountvers=3,mountproto=udp,local_lock=none,addr=192.168.33.1 0 2 >> /etc/fstab"
sudo mount -a
