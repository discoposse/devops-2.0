#!/bin/sh -eux
# install ant build tool by apache.

# install apache ant. ----------------------------------------------------------
antfolder="apache-ant-1.10.1"
antbinary="${antfolder}-bin.tar.gz"

# create apache parent folder.
mkdir -p /usr/local/apache
cd /usr/local/apache

# download ant binary from apache.org.
wget --no-verbose http://archive.apache.org/dist/ant/binaries/${antbinary}

# extract ant binary.
tar -zxvf ${antbinary} --no-same-owner --no-overwrite-dir
chown -R root:root ./${antfolder}
ln -s ${antfolder} apache-ant
rm -f ${antbinary}

# set jdk home environment variables.
JAVA_HOME=/usr/local/java/jdk180
export JAVA_HOME

# set ant home environment variables.
ANT_HOME=/usr/local/apache/apache-ant
export ANT_HOME
PATH=${ANT_HOME}/bin:${JAVA_HOME}/bin:$PATH
export PATH

# verify installation.
ant -version

# install apache ant contrib. --------------------------------------------------
acfolder="ant-contrib"
acrelease="1.0b3"
acbinary="${acfolder}-${acrelease}-bin.tar.gz"
acjar="${acfolder}-${acrelease}.jar"

# create apache contrib parent folder.
mkdir -p /usr/local/apache
cd /usr/local/apache

# download ant contrib library from sourceforge.net.
curl --silent --location "https://sourceforge.net/projects/${acfolder}/files/${acfolder}/${acrelease}/${acbinary}/download" --output ${acbinary}

# extract ant contrib binary.
tar -zxvf ${acbinary} --no-same-owner --no-overwrite-dir
chown -R root:root ./${acfolder}
rm -f ${acbinary}

# copy ant contrib library to apache-ant/lib.
cd /usr/local/apache/${acfolder}
cp -p ${acjar} /usr/local/apache/apache-ant/lib
