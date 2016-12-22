# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'fileutils'

global_personal_yaml_fn = File.expand_path('~/.personal_ansible_vm.yml')

if File.file?(global_personal_yaml_fn)
    FileUtils.cp(global_personal_yaml_fn, './')
end

Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/box/parallels/ubuntu1604-0.1.0.box"

  config.vm.network "private_network", ip: "192.168.33.10"

  config.vm.provider :parallels do |v|
    v.name = 'lxc'
    v.memory = '8192'
    v.cpus = 4
  end

  config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"

  config.vm.provision "shell", path: "provision.sh"
end
