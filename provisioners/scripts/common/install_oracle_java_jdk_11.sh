#!/bin/sh -eux
# install java se 11 development kit by oracle.

# install java se 11 development kit. ------------------------------------------
jdkhome="jdk11"
jdkbuild="11.0.1+13"
jdkhash="90cf5d8f270a4347a95050320eef3fb7"
jdkfolder="jdk-11.0.1"
jdkbinary="${jdkfolder}_linux-x64_bin.tar.gz"

# create java home parent folder.
mkdir -p /usr/local/java
cd /usr/local/java

# download jdk 11 binary from oracle otn.
wget --no-verbose --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/${jdkbuild}/${jdkhash}/${jdkbinary}

# extract jdk 11 binary and create softlink to 'jdk11'.
rm -f ${jdkhome}
tar -zxvf ${jdkbinary} --no-same-owner --no-overwrite-dir
chown -R root:root ./${jdkfolder}
ln -s ${jdkfolder} ${jdkhome}
rm -f ${jdkbinary}

# set jdk 11 home environment variables.
JAVA_HOME=/usr/local/java/${jdkhome}
export JAVA_HOME
PATH=${JAVA_HOME}/bin:$PATH
export PATH

# verify installation.
java -version
