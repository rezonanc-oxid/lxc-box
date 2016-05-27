#!/bin/bash

[ -f vagrant_1.8.1_x86_64.deb ] || wget https://releases.hashicorp.com/vagrant/1.8.1/vagrant_1.8.1_x86_64.deb
[ -f lxc.box ] || wget https://atlas.hashicorp.com/oxid_esales/boxes/trusty64-lxc/versions/1.0.0/providers/lxc.box
