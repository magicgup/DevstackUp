#!/bin/bash
set -e
set -x
apt-get update
apt-get install -qqy git vim python-setuptools libpq-dev python-dev libssl-dev libxml2-dev libxslt-dev gir1.2-gnomekeyring-1.0 pkg-config build-essential libnspr4-dev
easy_install --upgrade pip
git clone --depth=1 https://review.openstack.org/p/openstack-dev/devstack.git
cd devstack;
./tools/install_prereqs.sh;
cd ../
rm -rf devstack

git clone --depth=1 https://review.openstack.org/p/openstack/requirements.git
cd  requirements
mkdir /var/cache/pip
pip install --download-cache /var/cache/pip -r requirements.txt -r test-requirements.txt git-review
cd ../
rm -rf requirements


mkdir /opt/stack
cd /opt/stack
for i in nova glance swift cinder horizon keystone python-cinderclient python-glanceclient python-keystoneclient python-novaclient python-quantumclient tempest
do
  git clone https://review.openstack.org/p/openstack/$i.git
done
