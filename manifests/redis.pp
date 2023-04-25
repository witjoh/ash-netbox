# @summary Class that handles the installation of Redis
#
# Class that handles the installation of Redis
#
# @example
#   include netbox::redis
class netbox::redis {
  include redis

  firewalld_service { 'redis':
    ensure => 'present',
    zone   => 'public',
  }
}
