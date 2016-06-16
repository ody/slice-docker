class { '::openstack_extras::repo::debian::ubuntu':
  release         => 'newton',
  repo            => 'updates',
  package_require => true,
}

class { '::nova':
  database_connection     => 'mysql+pymysql://nova:nova@nova-mysql/nova?charset=utf8',
  api_database_connection => 'mysql+pymysql://nova_api:nova@nova-api-mysql/nova_api?charset=utf8',
  #rabbit_host             => $::openstack_integration::config::ip_for_url,
  #rabbit_port             => $::openstack_integration::config::rabbit_port,
  rabbit_userid           => 'nova',
  rabbit_password         => 'an_even_bigger_secret',
  #rabbit_use_ssl          => $::openstack_integration::config::ssl,
  #use_ipv6                => $::openstack_integration::config::ipv6,
  #glance_api_servers      => "${::openstack_integration::config::base_url}:9292",
  debug                   => true,
  notification_driver     => 'messagingv2',
  notify_on_state_change  => 'vm_and_task_state',
}
class { '::nova::api':
  admin_password                       => 'a_big_secret',
  #auth_uri                             => $::openstack_integration::config::keystone_auth_uri,
  #identity_uri                         => $::openstack_integration::config::keystone_admin_uri,
  #api_bind_address                     => $::openstack_integration::config::host,
  osapi_v3                             => true,
  neutron_metadata_proxy_shared_secret => 'a_big_secret',
  metadata_workers                     => 2,
  default_floating_pool                => 'public',
  sync_db                              => false,
  sync_db_api                          => false,
  service_name                         => 'httpd',
}
include '::apache'
class { '::nova::wsgi::apache':
  #bind_host => $::openstack_integration::config::ip_for_url,
  workers   => '2',
  ssl       => false,
}
