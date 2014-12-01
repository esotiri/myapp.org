#!/bin/sh

#su $SUDO_USER -s /bin/sh -c '. s1.sh'
# user
useradd plaid
# EPEL already enabled on HMDC VM
rpm -Uvh http://dl.fedoraproject.org/pub/epel/6Server/x86_64/epel-release-6-8.noarch.rpm
yum install -y httpd mod_wsgi ack elinks libjpeg-turbo-devel
rpm --import http://ftp.scientificlinux.org/linux/scientific/6.4/x86_64/os/RPM-GPG-KEY-sl
yum install -y http://ftp.scientificlinux.org/linux/scientific/6.4/x86_64/external_products/softwarecollections/yum-conf-softwarecollections-1.0-1.el6.noarch.rpm
yum install -y python27
echo "Setting up Django app" ##django1.7 => python2.7; django1.6=> python2.6
echo "Installing pip for Python 2.7"
scl enable python27 "easy_install pip"
echo "Install virtualenvwrapper"
scl enable python27 "pip install virtualenvwrapper"
#
echo "Setup virtualenv directory"
mkdir -p /webapps/virtualenvs
chown plaid /webapps/virtualenvs
mkdir /webapps/code
chown plaid /webapps/code

su plaid -l -s /bin/sh -c 'cd /webapps/code && cp -r /git/myapp.org .'
cp /webapps/code/myapp.org/deploy/files/etc/sudoers.d/plaid /etc/sudoers.d
chmod 640 /etc/sudoers.d/plaid
#
cp /git/myapp.org/myapp_org/myapp_org/settings/secret_settings_prod.json /webapps/code/myapp.org/myapp_org/myapp_org/settings/secret_settings_prod.json
chown plaid:apache /webapps/code/myapp.org/myapp_org/myapp_org/settings/secret_settings_prod.json
chmod 440 /webapps/code/myapp.org/myapp_org/myapp_org/settings/secret_settings_prod.json
#
# Create directory for sqlite db
echo "Create general data directory"
#
mkdir -p /webapps/data/myapp_org
chown apache /webapps/data/myapp_org
#
echo "Create data directory for sqlite db"
mkdir -p /webapps/data/myapp_org/sqlite
chown plaid:apache /webapps/data/myapp_org/sqlite
chmod 775 /webapps/data/myapp_org/sqlite


# configure apache
#
echo "Configure Apache"
cp /webapps/code/myapp.org/deploy/vagrant-centos-myapp_org.conf /etc/httpd/conf.d/myapp_org.conf
chown plaid /etc/httpd/conf.d/myapp_org.conf
cp -a /etc/sysconfig/httpd /etc/sysconfig/httpd.orig
cp /webapps/code/myapp.org/deploy/files/etc/sysconfig/httpd /etc/sysconfig/httpd
#
echo "Create /var/www directory owned by plaid"
mkdir /var/www/myapp_org
chown plaid /var/www/myapp_org
#
# Create directory for uploaded files
#
echo "Create data directory for uploaded files"
mkdir -p /webapps/data/myapp_org/myapp_org_uploaded_files
chown apache /webapps/data/myapp_org/myapp_org_uploaded_files
#
echo "run main setup script as Plaid user with python 2.7"

# having trouble runnign stage2 with su
echo "run stage2 "
su plaid -l -s /bin/sh -c 'scl enable python27 "/webapps/code/myapp.org/deploy/setup/stage2.sh"'
#
echo "Permissions for database"
chown plaid:apache /webapps/data/myapp_org/sqlite/myapp_org.db3
chmod 660 /webapps/data/myapp_org/sqlite/myapp_org.db3
echo "starting apache"
service httpd start
chkconfig httpd on
# on HMDC VM, changed SELinux to "permissive" in /etc/selinux/config
# sed -i -e 's/^SELINUX=.*/SELINUX=permissive/' /etc/selinux/config


