FROM 192.168.10.123/cloudwalk/oraclejdk131:1.0.0
MAINTAINER xiechuan  <xiechuanj@gmail.com>

RUN rpm -ivh http://repo.zabbix.com/zabbix/3.2/rhel/7/x86_64/zabbix-release-3.2-1.el7.noarch.rpm 
RUN yum install zabbix-server-mysql zabbix-web-mysql mariadb.x86_64 mariadb-libs.x86_64 -y 
RUN zcat /usr/share/doc/zabbix-server-mysql-3.2.*/create.sql.gz | mysql -hmysql-0.mysql -uzabbix -p zabbix 


#COPY createJenkinsNode.py ./

#ENTRYPOINT 
