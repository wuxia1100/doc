#!/bin/bash

while getopts "t:s:j:h" arg #选项后面的冒号表示该选项需要参数
do
        case $arg in
             t)
                TOMCAT_HOME=$OPTARG
		 ;;
             s)
		SERVICE_NAME=$OPTARG
                ;;
             j)
		JAVA_HOME=$OPTARG
                ;;
	     h)
		echo "usage:"
		echo "./install-tomcat-service.sh -t TOMCAT_HOME_PATH -s SERVICE_NAME -j JAVA_HOME "
		;;
             ?)
           	echo "usage:"
                echo "./install-tomcat-service.sh -t TOMCAT_HOME_PATH -s SERVICE_NAME -j JAVA_HOME "
        
		exit 1
        	;;
        esac
done

echo "TOMCAT_HOME=$TOMCAT_HOME"
echo "JAVA_HOME=$JAVA_HOME"
echo "SERVICE_NAME=$SERVICE_NAME"

echo "[Unit]" > /etc/systemd/system/$SERVICE_NAME.service
echo "    Description=$SERVICE_NAME" >> /etc/systemd/system/$SERVICE_NAME.service
echo "    After=syslog.target network.target" >> /etc/systemd/system/$SERVICE_NAME.service
echo "[Service]" >> /etc/systemd/system/$SERVICE_NAME.service
echo "    Type=forking" >> /etc/systemd/system/$SERVICE_NAME.service
echo "    User=tomcat" >> /etc/systemd/system/$SERVICE_NAME.service
echo "    Group=tomcat" >> /etc/systemd/system/$SERVICE_NAME.service
echo "    Environment=JAVA_HOME=$JAVA_HOME" >> /etc/systemd/system/$SERVICE_NAME.service
echo "    Environment=CATALINA_PID=$TOMCAT_HOME/temp/tomcat.pid" >> /etc/systemd/system/$SERVICE_NAME.service
echo "    Environment=CATALINA_HOME=$TOMCAT_HOME" >> /etc/systemd/system/$SERVICE_NAME.service
echo "    Environment=CATALINA_BASE=$TOMCAT_HOME" >> /etc/systemd/system/$SERVICE_NAME.service
echo "    Environment='JAVA_OPTS=-Djava.awt.headless=true -Djava.security.egd=file:/dev/./urandom'" >> /etc/systemd/system/$SERVICE_NAME.service
echo "    ExecStart=$TOMCAT_HOME/bin/startup.sh" >> /etc/systemd/system/$SERVICE_NAME.service
echo "    ExecStop=/bin/kill -15 $MAINPID" >> /etc/systemd/system/$SERVICE_NAME.service
echo "[Install]" >> /etc/systemd/system/$SERVICE_NAME.service
echo "    WantedBy=multi-user.target" >> /etc/systemd/system/$SERVICE_NAME.service

`systemctl enable $SERVICE_NAME`
