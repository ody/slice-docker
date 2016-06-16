#!/usr/bin/env bash

PATH=/opt/puppetlabs/server/bin:/opt/puppetlabs/puppet/bin:/opt/puppetlabs/bin:$PATH

apt-get update
apt-get install -y wget
wget https://apt.puppetlabs.com/puppetlabs-release-pc1-xenial.deb
dpkg -i puppetlabs-release-pc1-xenial.deb
rm puppetlabs-release-pc1-xenial.deb
apt-get update
apt-get install --no-install-recommends -y puppet-agent
apt-get clean
curl -SL https://github.com/grammarly/rocker/releases/download/1.2.0/rocker-1.2.0-linux_amd64.tar.gz | tar -xzC /usr/local/bin && chmod +x /usr/local/bin/rocker

/opt/puppetlabs/puppet/bin/gem install r10k --no-ri --no-rdoc

r10k puppetfile install --moduledir /etc/puppetlabs/code/modules --puppetfile /vagrant/Puppetfile
puppet apply -v /vagrant/manifests/site.pp
