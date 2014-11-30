#!/bin/sh

su $SUDO_USER -s /bin/sh -c '. s1.sh'
# user
useradd plaid
# base                                                                                                                
yum install -y  wget
# install postgres server 9.3
wget http://yum.postgresql.org/9.3/redhat/rhel-6-x86_64/pgdg-centos93-9.3-1.noarch.rpm
rpm -ivh pgdg-centos93-9.3-1.noarch.rpm
yum install python27-python-psycopg2.x86_64
# Epel
rpm -Uvh http://dl.fedoraproject.org/pub/epel/6Server/x86_64/epel-release-6-8.noarch.rpm

echo "install apache ..."
yum install -y httpd mod_wsgi ack elinks libjpeg-turbo-devel

echo "softare collection"
rpm --import http://ftp.scientificlinux.org/linux/scientific/6.4/x86_64/os/RPM-GPG-KEY-sl
yum install -y http://ftp.scientificlinux.org/linux/scientific/6.4/x86_64/external_products/softwarecollections/yum-conf-softwarecollections-1.0-1.el6.noarch.rpm

echo "Install Python27"
yum install -y python27

echo "instll pip"
scl enable python27 "easy_install pip"

echo "Install virtualenvwrapper"
scl enable python27 "pip install virtualenvwrapper"



