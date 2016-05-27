# Quick install

```bash
git clone --recursive https://github.com/rezonanc-oxid/lxc-box.git box
cd box
./download_resources.sh
cd ubuntu

# adjust ubuntu.json
# modify "ssh_uid" and "ssh_gid" to match your user uid/gid

packer build -only=parallels-iso -var-file=ubuntu1604.json ubuntu.json
vagrant up
```
