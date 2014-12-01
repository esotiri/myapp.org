#!/bin/sh
# This script should be wrapped by another script that
# encloses all of these commands in "scl enable python27"
# and is run by the "plaid" user one time for setup.
# i.e. scl enable python27 "path/to/this/script.sh"
# See also http://developerblog.redhat.com/2013/02/14/setting-up-django-and-python-2-7-on-red-hat-enterprise-6-the-easy-way/

#source /usr/bin/virtualenvwrapper.sh # python 2.6 version
source /opt/rh/python27/root/usr/bin/virtualenvwrapper.sh
#
# Setup virtualenv
echo "Setup virtualenv"
mkdir -p /webapps/virtualenvs
export WORKON_HOME=/webapps/virtualenvs
mkvirtualenv myapp_org
workon myapp_org
# Install requirements (pip)
echo "Install requirements (pip)"
cd /webapps/code/myapp.org
pip install -r requirements/production.txt
#
# Validate settings file
#
echo "Validate settings file"
cd /webapps/code/myapp.org/myapp_org
python manage.py validate --settings=myapp_org.settings.production
#
# Create sqlite database + initial tables
#
echo "Create sqlite database + initial tables"
python manage.py syncdb --noinput --settings=myapp_org.settings.production
#
echo "Create www directories (media/static/wsgi-related)"
mkdir /var/www/myapp_org/media # user uploads
mkdir /var/www/myapp_org/static # images, js, css, etc.
mkdir /var/www/myapp_org/myapp_org # wsgi.py
cp /webapps/code/myapp.org/myapp_org/myapp_org/vagrant-centos-wsgi.py /var/www/myapp_org/myapp_org/wsgi.py
#
echo "Run collecstatic to copy files to the static www directory"
#
python manage.py collectstatic --noinput --settings=myapp_org.settings.production
echo "Create directory for federated myapp logos"
mkdir -p /var/www/myapp_org/media/federated_logos
#cp /webapps/code/myapp.org/myapp/media/federated_logos/* /var/www/myapp/media/federated_logos
#python manage.py loaddata apps/federated_myapp/fixtures/test-data.json --settings=myapp_org.settings.production
