# @summary Sets up the PostgreSQL database for netbox
#
# This class sets up PostgreSQL database. This is optional,
# you can choose to handle that yourself.
#
# @param database_name
#   Name of the PostgreSQL database.
#
# @param database_user
#   Name of the PostgreSQL database user.
#
# @param database_password
#   Name of the PostgreSQL database password.
#
# @param database_encoding
#   Encoding used by the PostgreSQL database.
#
# @param database_locale
#   Locale used by the PostgreSQL database.
#
# @param database_version
#   Version of PostgreSQL to install
#
# @example
#   include netbox::database
class netbox::database (
  String $database_name,
  String $database_user,
  Sensitive[String] $database_password,
  String $database_encoding,
  String $database_locale,
  String $database_version,
) {
  if $facts['os']['family'] == 'RedHat' and $facts['os']['release']['major'] == '8' {
    $manage_dnf_module = true
  } else {
    $manage_dnf_module = false
  }

  class { 'postgresql::globals':
    encoding          => $database_encoding,
    locale            => $database_locale,
    version           => $database_version,
    manage_dnf_module => $manage_dnf_module,
  }
  ->class { 'postgresql::server':
  }

  postgresql::server::db { $database_name:
    user     => $database_user,
    password => postgresql_password($database_name, $database_password),
  }

  postgresql::server::database_grant { 'user_ALL_on_database':
    privilege => 'ALL',
    db        => $database_name,
    role      => $database_user,
  }

  firewalld_service { 'postgresql':
    ensure => 'present',
    zone   => 'public',
  }
}
