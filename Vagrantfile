# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'vagrant-openstack-provider'
require 'securerandom'

PLATFORM = ENV['PLATFORM'] || 'ubuntu-16.04-x86_64'

Vagrant.configure('2') do |config|

  config.vm.box               = 'dummy'
  config.ssh.username         = PLATFORM.split('-')[0]
  config.ssh.pty              = true
  config.ssh.private_key_path = "#{ENV['HOME']}/.ssh/vagrant.pem"

  config.vm.provider :openstack do |os|
    os.server_name        = "slice-docker-#{SecureRandom.hex(4)}"
    os.openstack_auth_url = ENV['OS_AUTH_URL']
    os.username           = ENV['OS_USERNAME']
    os.password           = ENV['OS_PASSWORD']
    # Setting "tenent_name" to OS_PROJECT_NAME because "tenant" is deprecated and
    # replaced by the "project" concept.  Make sure your openrc has OS_TENANT_NAME
    # and OS_PROJECT_NAME set to the same value.  This is just good practice
    # overall because different OpenStack clients support different values
    # depending on which version of each client you use.
    os.tenant_name        = ENV['OS_PROJECT_NAME']
    os.flavor             = 'g1.medium'
    os.image              = PLATFORM.gsub('-', '_')
    os.floating_ip_pool   = 'ext-net-pdx1-opdx1'
    os.keypair_name       = 'vagrant'
    os.security_groups    = ['sg0']
  end

  config.vm.provision('shell', path: 'docker.sh', privileged: true)
end
