# @summary Configures Netbox and gunicorn
#
# Configures Netbox and gunicorn, and load the database schema.
#
# @param user
#   The user owning the Netbox installation files, and running the
#   service.
#
# @param group
#   The group owning the Netbox installation files, and running the
#   service.
#
# @param install_root
#   The directory where the netbox installation is unpacked
#
# @param allowed_hosts
#   Array of valid fully-qualified domain names (FQDNs) for the NetBox server. NetBox will not permit write
#   access to the server via any other hostnames. The first FQDN in the list will be treated as the preferred name.
#
# @param database_name
#   Name of the PostgreSQL database. If handle_database is true, then this database
#   gets created as well. If not, then it is only used by the application, and needs to exist.
#
# @param database_user
#   Name of the PostgreSQL database user. If handle_database is true, then this database user
#   gets created as well. If not, then it is only used by the application, and needs to exist.
#
# @param database_password
#   Name of the PostgreSQL database password. If handle_database is true, then this database password
#   gets created as well. If not, then it is only used by the application, and needs to exist.
#
# @param admins
#   Array of hashes with two keys, 'name' and 'email'. This is where the email goes if something goes wrong
#   This feature (in the Puppet module) is not well tested.
#
# @param database_host
#   Hostname where the PostgreSQL database resides.
#
# @param database_port
#   PostgreSQL database port. NB! The PostgreSQL database that is made when using handle_database
#   does not support configuring a non-standard port. So change this parameter only if using
#   separate PostgreSQL DB with non-standard port. Defaults to 5432.
#
# @param database_conn_max_age
#   Database max connection age in seconds. Defaults to 300.
#
# @param redis_options
#   Options used against redis. Customize to fit your redis installation. Use default values
#   if using the redis bundled with this module.
#
# @param email_options
#   Options used for sending email.
#
# @param secret_key
#   A random string of letters, numbers and symbols that Netbox needs.
#   This needs to be supplied, and should be treated as a secret. Should
#   be at least 50 characters long.
#
# @param banner_top
#   Text for top banner on the Netbox webapp
#
# @param banner_bottom
#   Text for bottom banner on the Netbox webapp
#
# @param banner_login
#   Text for login banner on the Netbox webapp
#
# @param base_path
#   Base URL path if accessing NetBox within a directory.
#   For example, if installed at http://example.com/netbox/, set: BASE_PATH = 'netbox/'
#
# @param debug
#   Set to True to enable server debugging. WARNING: Debugging introduces a substantial performance penalty and may reveal
#   sensitive information about your installation. Only enable debugging while performing testing. Never enable debugging
#   on a production system.
#
# @param enforce_global_unique
#   Enforcement of unique IP space can be toggled on a per-VRF basis. To enforce unique IP space within the global table
#   (all prefixes and IP addresses not assigned to a VRF), set ENFORCE_GLOBAL_UNIQUE to True.
#
# @param login_required
#   Setting this to True will permit only authenticated users to access any part of NetBox. By default, anonymous users
#   are permitted to access most data in NetBox (excluding secrets) but not make any changes.
#
# @param metrics_enabled
#   Setting this to true exposes Prometheus metrics at /metrics.
#   See the Promethues Metrics documentation for more details:
#   https://netbox.readthedocs.io/en/stable/additional-features/prometheus-metrics/)
#
# @param prefer_ipv4
#   When determining the primary IP address for a device, IPv6 is preferred over IPv4 by default. Set this to True to
#   prefer IPv4 instead.
#
# @param exempt_view_permissions
#   Exempt certain models from the enforcement of view permissions. Models listed here will be viewable by all users and
#   by anonymous users. List models in the form `<app>.<model>`. Add '*' to this list to exempt all models.
#
# @param napalm_username
#   Username that NetBox will uses to authenticate to devices when connecting via NAPALM.
#
# @param napalm_password
#   Password that NetBox will uses to authenticate to devices when connecting via NAPALM.
#
# @param napalm_timeout
#   NAPALM timeout (in seconds).
#
# @param time_zone
# Date/time formatting. See the following link for supported formats:
# https://docs.djangoproject.com/en/stable/ref/templates/builtins/#date
#
# @param date_format
# Date/time formatting. See the following link for supported formats:
# https://docs.djangoproject.com/en/stable/ref/templates/builtins/#date
#
# @param short_date_format
# Date/time formatting. See the following link for supported formats:
# https://docs.djangoproject.com/en/stable/ref/templates/builtins/#date
#
# @param time_format
# Date/time formatting. See the following link for supported formats:
# https://docs.djangoproject.com/en/stable/ref/templates/builtins/#date
#
# @param short_time_format
# Date/time formatting. See the following link for supported formats:
# https://docs.djangoproject.com/en/stable/ref/templates/builtins/#date
#
# @param datetime_format
# Date/time formatting. See the following link for supported formats:
# https://docs.djangoproject.com/en/stable/ref/templates/builtins/#date
#
# @param short_datetime_format
# Date/time formatting. See the following link for supported formats:
# https://docs.djangoproject.com/en/stable/ref/templates/builtins/#date
#
# @param ldap_server
#   FQDN of ldap server
#
# @param ldap_service_account_cn
#   Netbox service account cn
#
# @param ldap_service_account_password
#   Netbox service account password
#
# @param ldap_service_account_ou
#   Netbox service account ou
#
# @param ldap_user_search_ou
#   OU to search for when users try logging into netbox
#
# @param ldap_netbox_login_user_cn
#   CN needed for users to be able to log into netbox
#
# @param ldap_full_dc
#   Complete dc to lookup when searching for users
#   Example: dc=example,dc=com
#
# @param ldap_netbox_group_ou
#   OU to seach when looking for netbox related CN's
#
# @param ldap_netbox_active_user_cn
#   CN for active user in netbox.  This is required by all users within netbox
#
# @param ldap_netbox_staff_user_cn
#   CN for staff user in netbox
#
# @param ldap_netbox_superuser_user_cn
#   CN for superuser in netbox
#
# @example
#   include netbox::install
class netbox::install (
  String $user,
  String $group,
  Stdlib::Absolutepath $install_root,
  Array[Stdlib::Host] $allowed_hosts,
  String $database_name,
  String $database_user,
  String $database_password,
  Stdlib::Host $database_host,
  Integer $database_port,
  Integer $database_conn_max_age,
  Hash $redis_options,
  Hash $email_options,
  String $secret_key,
  Array $admins,
  String $banner_top,
  String $banner_bottom,
  String $banner_login,
  String $base_path,
  Boolean $debug,
  Boolean $enforce_global_unique,
  Boolean $login_required,
  Boolean $metrics_enabled,
  Boolean $prefer_ipv4,
  Array $exempt_view_permissions,
  String $napalm_username,
  String $napalm_password,
  Integer $napalm_timeout,
  String $time_zone,
  String $date_format,
  String $short_date_format,
  String $time_format,
  String $short_time_format,
  String $datetime_format,
  String $short_datetime_format,
  Boolean $include_napalm,
  Boolean $include_django_storages,
  Boolean $include_ldap,

  # LDAP params
  Optional[String] $ldap_server,
  Optional[String] $ldap_service_account_cn,
  Optional[String] $ldap_service_account_password,
  Optional[String] $ldap_service_account_ou,
  Optional[String] $ldap_user_search_ou,
  Optional[String] $ldap_full_dc,
  Optional[String] $ldap_netbox_login_user_cn,
  Optional[String] $ldap_netbox_group_ou,
  Optional[String] $ldap_netbox_active_user_cn,
  Optional[String] $ldap_netbox_staff_user_cn,
  Optional[String] $ldap_netbox_superuser_user_cn,
) {
  $should_create_superuser = false;
  $software_directory = "${install_root}/netbox"
  $venv_dir = "${software_directory}/venv"
  $gunicorn_file = "${software_directory}/gunicorn.py"

  $gunicorn_settings = {
    port                => 8001,
    workers             => 5,
    threads             => 3,
    timeout             => 120,
    max_requests        => 5000,
    max_requests_jitter => 500,
  }

  file { $gunicorn_file:
    content => epp('netbox/gunicorn.py.epp', $gunicorn_settings),
    owner   => $user,
    group   => $group,
    mode    => '0644',
  }

  file { 'local_requirements':
    ensure  => 'present',
    path    => "${software_directory}/local_requirements.txt",
    owner   => $user,
    group   => $group,
    require => File[$gunicorn_file],
  }

  if $include_napalm {
    file_line { 'napalm':
      path    => "${software_directory}/local_requirements.txt",
      line    => 'napalm',
      require => File['local_requirements']
    }

    firewalld_port { 'Open port 830 for napalm':
      ensure   => present,
      zone     => 'public',
      port     => 830,
      protocol => 'tcp',
    }
  }

  if $include_django_storages {
    file_line { 'django_storages':
      path    => "${software_directory}/local_requirements.txt",
      line    => 'django-storages',
      require => File['local_requirements']
    }
  }

  if $include_ldap {
    file_line { 'ldap':
      path    => "${software_directory}/local_requirements.txt",
      line    => 'django-auth-ldap',
      require => File['local_requirements']
    }

    file {"${software_directory}/netbox/netbox/ldap_config.py":
      content => epp('netbox/ldap_config.py.epp', {
        'server'                   => $ldap_server,
        'service_account_cn'       => $ldap_service_account_cn,
        'service_account_password' => $ldap_service_account_password,
        'service_account_ou'       => $ldap_service_account_ou,
        'full_dc'                  => $ldap_full_dc,
        'user_search_ou'           => $ldap_user_search_ou,
        'netbox_login_group_cn'    => $ldap_netbox_login_user_cn,
        'netbox_group_ou'          => $ldap_netbox_group_ou,
        'netbox_active_user_cn'    => $ldap_netbox_active_user_cn,
        'netbox_staff_user_cn'     => $ldap_netbox_staff_user_cn,
        'netbox_superuser_user_cn' => $ldap_netbox_superuser_user_cn,
      }),
      owner   => $user,
      group   => $group,
      mode    => '0644',
    }
  }

  $config_file = "${software_directory}/netbox/netbox/configuration.py"

  file { $config_file:
    content => epp('netbox/configuration.py.epp', {
      'allowed_hosts'           => $allowed_hosts,
      'database_name'           => $database_name,
      'database_user'           => $database_user,
      'database_password'       => $database_password,
      'database_host'           => $database_host,
      'database_port'           => $database_port,
      'database_conn_max_age'   => $database_conn_max_age,
      'redis_options'           => $redis_options,
      'email_options'           => $email_options,
      'secret_key'              => $secret_key,
      'admins'                  => $admins,
      'banner_top'              => $banner_top,
      'banner_bottom'           => $banner_bottom,
      'banner_login'            => $banner_login,
      'base_path'               => $base_path,
      'debug'                   => $debug,
      'enforce_global_unique'   => $enforce_global_unique,
      'exempt_view_permissions' => $exempt_view_permissions,
      'login_required'          => $login_required,
      'metrics_enabled'         => $metrics_enabled,
      'prefer_ipv4'             => $prefer_ipv4,
      'napalm_username'         => $napalm_username,
      'napalm_password'         => $napalm_password,
      'napalm_timeout'          => $napalm_timeout,
      'time_zone'               => $time_zone,
      'date_format'             => $date_format,
      'short_date_format'       => $short_date_format,
      'time_format'             => $time_format,
      'short_time_format'       => $short_time_format,
      'datetime_format'         => $datetime_format,
      'short_datetime_format'   => $short_datetime_format,
      'include_ldap'            => $include_ldap,
    }),
    owner   => $user,
    group   => $group,
    mode    => '0644',
  }

  $tmp_venv_dir = '/tmp/netbox_venv'

  python::pyvenv { $tmp_venv_dir:
    ensure   => present,
    version  => '3.8',
    venv_dir => $tmp_venv_dir,
    owner    => $user,
    group    => $group,
    before   => Exec['upgrade script'],
  }

  exec {'upgrade script':
    command     => "${software_directory}/upgrade.sh",
    environment => ["PYTHON=${tmp_venv_dir}/bin/python3.8"],
    require     => File[$config_file],
    path        => '/usr/bin',
    cwd         => $software_directory
  }

  file {'/etc/cron.daily/netbox-housekeeping':
    ensure => link,
    target => "${software_directory}/contrib/netbox-housekeeping.sh",
    owner  => $user,
    group  => $group,
  }

  facter::fact { 'netbox_installed':
    value => true,
  }
}
