#!/bin/sh -eux
# create default headless (command-line) environment profiles for devops users.

# create default environment profile for user 'root'. --------------------------
rootprofile="/vagrant/scripts/users/user-root-bash_profile.sh"
rootrc="/vagrant/scripts/users/user-root-bashrc.sh"

# uncomment proxy environment variables (if set).
proxy_set="${http_proxy:-}"
if [ -n "${proxy_set}" ]; then
  sed -i 's/#http_proxy/http_proxy/g;s/#export http_proxy/export http_proxy/g' ${rootrc}
  sed -i 's/#https_proxy/https_proxy/g;s/#export https_proxy/export https_proxy/g' ${rootrc}
fi

# copy environment profiles to user 'root' home.
cd /root
cp -p .bash_profile .bash_profile.orig
cp -p .bashrc .bashrc.orig

cp -f ${rootprofile} .bash_profile
cp -f ${rootrc} .bashrc

# remove existing vim profile if it exists.
if [ -d ".vim" ]; then
  rm -Rf ./.vim
fi

cp -f /vagrant/scripts/tools/vim-files.tar.gz .
tar -zxvf vim-files.tar.gz --no-same-owner --no-overwrite-dir
rm -f vim-files.tar.gz

chown -R root:root .
chmod 644 .bash_profile .bashrc

# create default environment profile for user 'vagrant'. -----------------------
vagrantprofile="/vagrant/scripts/users/user-vagrant-bash_profile.sh"
vagrantrc="/vagrant/scripts/users/user-vagrant-bashrc.sh"

# uncomment proxy environment variables (if set).
proxy_set="${http_proxy:-}"
if [ -n "${proxy_set}" ]; then
  sed -i 's/#http_proxy/http_proxy/g;s/#export http_proxy/export http_proxy/g' ${vagrantrc}
  sed -i 's/#https_proxy/https_proxy/g;s/#export https_proxy/export https_proxy/g' ${vagrantrc}
fi

# copy environment profiles to user 'vagrant' home.
cd /home/vagrant
cp -p .bash_profile .bash_profile.orig
cp -p .bashrc .bashrc.orig

cp -f ${vagrantprofile} .bash_profile
cp -f ${vagrantrc} .bashrc

# remove existing vim profile if it exists.
if [ -d ".vim" ]; then
  rm -Rf ./.vim
fi

cp -f /vagrant/scripts/tools/vim-files.tar.gz .
tar -zxvf vim-files.tar.gz --no-same-owner --no-overwrite-dir
rm -f vim-files.tar.gz

chown -R vagrant:vagrant .
chmod 644 .bash_profile .bashrc