#!/bin/bash  

echo "install apr-1.6.3 ......"

cd /usr/local/src
wget http://mirrors.shuosc.org/apache//apr/apr-1.6.3.tar.gz
tar -xzvf apr-1.6.3.tar.gz
cd apr-1.6.3
./configure --prefix=/usr/local/apr
make
make install

echo "install expat-devel for apr-util...."

yum -y install expat-devel

echo "install apr-util-1.6.1 ......"

cd /usr/local/src
wget http://mirrors.shuosc.org/apache/apr/apr-util-1.6.1.tar.gz
tar -xzvf apr-util-1.6.1.tar.gz
cd apr-util-1.6.1
./configure --with-apr=/usr/local/apr --with-jdk=/usr/java/jdk-1.8.0_151
make
make install


