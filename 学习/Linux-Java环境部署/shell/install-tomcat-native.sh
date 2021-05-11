#!/bin/bash  

echo "install tomcat-native..."

echo $1

`cd $1/bin`
tar -xzvf tomcat-native.tar.gz
cd tomcat-native-*
cd native
./configure --with-apr=/usr/local/apr --with-ssl=/usr/local/openssl
make
make install
