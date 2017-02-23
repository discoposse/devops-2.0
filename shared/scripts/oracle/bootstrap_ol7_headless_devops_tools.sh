#!/bin/sh -eux
# install useful headless (command-line) developer tools.

# create temporary scripts directory. ------------------------------------------
mkdir -p /tmp/scripts/oracle
cd /tmp/scripts/oracle

# install epel repository if needed. -------------------------------------------
if [ ! -f "/etc/yum.repos.d/epel.repo" ]; then
  wget --no-verbose https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
  yum repolist
  yum -y install epel-release-latest-7.noarch.rpm
fi

# update the repository list. --------------------------------------------------
yum repolist

# install python 2.x pip and setuptools. ---------------------------------------
yum -y install python-pip
python --version
pip --version

# upgrade python 2.x pip.
pip install --upgrade pip
pip --version

# install python 2.x setup tools.
yum -y install python-setuptools
#pip install --upgrade setuptools
pip install 'setuptools==33.1.1'
easy_install --version

# install software collections library. (needed later for python 3.x.) ---------
yum -y install scl-utils

# install git. -----------------------------------------------------------------
yum -y install git
git --version
