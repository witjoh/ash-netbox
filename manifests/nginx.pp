
# @summary Configures Nginx
#
# Configures Nginx and forwards all requests to the netbox app
#
# @param user
#   The user owning the Netbox installation files, and running the
#   service.
#
# @param group
#   The group owning the Netbox installation files, and running the
#   service.
#
# @param server_name
#   FQDN of nginx server
#
# @param proxy_host
#   Server to proxy requests to
#
# @param proxy_port
#   Port proxy server is listening on
#
# @param cert_path
#   Path to cert for nginx
#
# @param private_key_path
#   Path to private key for nginx
#
# @param api_auth_parameters
#   Credentials to generate a cert for nginx
#
class netbox::nginx (
  String $user,
  String $group,
  String $server_name,
  String $proxy_host,
  String $proxy_port,
  String $cert_path,
  String $private_key_path,
  Hash $api_auth_parameters,
){
  include nginx

  $nginx_settings = {
    server_name      => $server_name,
    proxy_host       => $proxy_host,
    proxy_port       => $proxy_port,
    cert_path        => $cert_path,
    private_key_path => $private_key_path,
  }

  file {'/etc/nginx/sites-available/netbox':
    ensure  => present,
    content => epp('netbox/nginx.conf.epp', $nginx_settings),
    owner   => $user,
    group   => $group,
    mode    => '0644',
  }

  file {'/etc/nginx/sites-enabled/netbox':
    ensure    => link,
    target    => '/etc/nginx/sites-available/netbox',
    subscribe => File['/etc/nginx/sites-available/netbox'],
  }

  file {'/etc/nginx/sites-enabled/default':
    ensure => absent,
    before => File['/etc/nginx/sites-available/netbox'],
    owner  => $user,
    group  => $group,
    mode   => '0644',
  }

  encore_utils::cert {'netbox':
    owner               => $user,
    group               => $group,
    notify              => Service['nginx'],
    api_auth_parameters => $api_auth_parameters,
  }

  firewalld_port { 'Open port 80 for nginx':
    ensure   => present,
    zone     => 'public',
    port     => 80,
    protocol => 'tcp',
  }

  firewalld_port { 'Open port 443 for nginx':
    ensure   => present,
    zone     => 'public',
    port     => 443,
    protocol => 'tcp',
  }
}
