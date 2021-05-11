cd /opt
wget http://mirrors.tuna.tsinghua.edu.cn/apache/tomcat/tomcat-8/v8.5.24/bin/apache-tomcat-8.5.24.tar.gz
tar -xvf apache-tomcat-8.5.24.tar.gz

# install profile dev & prd
cp -R apache-tomcat-8.5.24 tomcat-dev
mv apache-tomcat-8.5.24 tomcat-prd

# add tomcat user
groupadd tomcat
useradd -M -s /bin/nologin -g tomcat -d /opt/tomcat-dev tomcat
chown -R tomcat:tomcat /opt/tomcat-dev
chown -R tomcat:tomcat /opt/tomcat-prd
