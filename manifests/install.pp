# @summary Configures Netbox and gunicorn
#
# Configures Netbox and gunicorn, and load the database schema.
#
# @param version
#   The version on netbox to install
#
# @param software_directory
#   The directory where netbox will be installed
#
# @param user
#   The user owning the Netbox installation files, and running the
#   service.
#
# @param group
#   The group owning the Netbox installation files, and running the
#   service.
#
# @param allowed_hosts
#   Array of valid fully-qualified domain names (FQDNs) for the NetBox server. NetBox will not permit write
#   access to the server via any other hostnames. The first FQDN in the list will be treated as the preferred name.
#
# @param database_version
#   Version of the PostgreSQL database
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
# @param admins
#   Array of hashes with two keys, 'name' and 'email'. This is where the email goes if something goes wrong
#   This feature (in the Puppet module) is not well tested.
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
# @param run_update_script
#   Determines whether to run update script or not
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
# @param include_napalm
#   Determines whether to install napalm packages along with opening port
#   for napalm to work
#
# @param include_django_storages
#   Determines whether to install django_storages packages
#
# @param include_ldap
#   Determines whether to install ldap packages along with setting up ldap
#   configuration file
#
# @param python_version
#   Python version to use when creating temp virtual env for installing netbox
#   This allows user to update version if netbox's requirements change
#
# @param log_dir_path
#   Directory where to store netbox log file
#
# @param log_file
#   Filename of netbox log file
#
# @param log_file_max_bytes
#   Max file size in bytes that is allowed per log file
#
# @param num_of_log_backups
#   Number of log files kept in backup before being rotated out
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
# @param ldap_dc
#   Complete dc to lookup when searching for users
#   Example: dc=example,dc=com
#
# @param ldap_netbox_group_ou
#   OU to search when looking for netbox related CN's
#
# @param ldap_netbox_ro_user_cn
#   CN for read only user in netbox
#
# @param ldap_netbox_admin_user_cn
#   CN for admin user in netbox
#
# @param ldap_netbox_super_user_cn
#   CN for super user in netbox
#
# @example
#   include netbox::install
class netbox::install (
  String $version,
  Stdlib::Absolutepath $software_directory,
  String $user,
  String $group,
  Array[Stdlib::Host] $allowed_hosts,
  String $database_version,
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
  Optional[String] $banner_top,
  Optional[String] $banner_bottom,
  Optional[String] $banner_login,
  Optional[String] $base_path,
  Boolean $debug,
  Boolean $enforce_global_unique,
  Boolean $login_required,
  Boolean $metrics_enabled,
  Boolean $prefer_ipv4,
  Boolean $run_update_script,
  Array $exempt_view_permissions,
  Optional[String] $napalm_username,
  Optional[String] $napalm_password,
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
  String $python_version,
  Optional[Stdlib::Absolutepath] $log_dir_path = undef,
  Optional[String] $log_file = undef,
  Integer $log_file_max_bytes = 1024 * 500,
  Integer $num_of_log_backups = 5,

  # LDAP params
  Optional[String] $ldap_server,
  Optional[String] $ldap_service_account_cn,
  Optional[String] $ldap_service_account_password,
  Optional[String] $ldap_service_account_ou,
  Optional[String] $ldap_dc,
  Optional[String] $ldap_netbox_group_ou,
  Optional[String] $ldap_netbox_ro_user_cn,
  Optional[String] $ldap_netbox_admin_user_cn,
  Optional[String] $ldap_netbox_super_user_cn,
) {
  $software_directory_with_version = "${software_directory}-${version}"
  $venv_dir = "${software_directory_with_version}/venv"
  $gunicorn_file = "${software_directory_with_version}/gunicorn.py"

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

  if $log_dir_path and $log_file {
    $_log_file_path = "${log_dir_path}${log_file}"
  }

  file { 'local_requirements':
    ensure  => file,
    path    => "${software_directory_with_version}/local_requirements.txt",
    owner   => $user,
    group   => $group,
    require => File[$gunicorn_file],
  }

  if $include_napalm {
    file_line { 'napalm':
      path    => "${software_directory_with_version}/local_requirements.txt",
      line    => 'napalm',
      require => File['local_requirements'],
    }

    firewalld_custom_service { 'napalm':
      ensure => 'present',
      port   => [
        {
          port     => 830,
          protocol => 'tcp',
        },
      ],
    }

    firewalld_service { 'napalm':
      ensure => 'present',
      zone   => 'public',
    }
  }

  if $include_django_storages {
    file_line { 'django_storages':
      path    => "${software_directory_with_version}/local_requirements.txt",
      line    => 'django-storages',
      require => File['local_requirements'],
    }
  }

  if $include_ldap {
    file_line { 'ldap':
      path    => "${software_directory_with_version}/local_requirements.txt",
      line    => 'django-auth-ldap',
      require => File['local_requirements'],
    }

    file { "${software_directory_with_version}/netbox/netbox/ldap_config.py":
      ensure  => file,
      content => epp('netbox/ldap_config.py.epp', {
          'server'                   => $ldap_server,
          'service_account_cn'       => $ldap_service_account_cn,
          'service_account_password' => $ldap_service_account_password,
          'service_account_ou'       => $ldap_service_account_ou,
          'dc'                       => $ldap_dc,
          'netbox_group_ou'          => $ldap_netbox_group_ou,
          'netbox_ro_user_cn'        => $ldap_netbox_ro_user_cn,
          'netbox_admin_user_cn'     => $ldap_netbox_admin_user_cn,
          'netbox_super_user_cn'     => $ldap_netbox_super_user_cn,
          'log_file_path'            => $_log_file_path,
          'log_file_max_bytes'       => $log_file_max_bytes,
          'num_of_log_backups'       => $num_of_log_backups,
      }),
      owner   => $user,
      group   => $group,
      mode    => '0644',
    }
  }

  $config_file = "${software_directory_with_version}/netbox/netbox/configuration.py"

  file { $config_file:
    ensure  => file,
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
        'log_file'                => $log_file,
    }),
    owner   => $user,
    group   => $group,
    mode    => '0644',
  }

  $_tmp_venv = "${software_directory_with_version}/tmp_venv"

  # This tmp venv is created because the latest versions of netbox
  # (as of this writing) requires at least python3.8 to run the upgrade script
  # so instead of messing with python at OS level, just create tmp venv
  # to run script
  python::pyvenv { $_tmp_venv:
    ensure   => present,
    version  => $python_version,
    venv_dir => $_tmp_venv,
    owner    => $user,
    group    => $group,
    before   => Exec['upgrade script'],
  }

  exec { 'upgrade script':
    command     => "${software_directory_with_version}/upgrade.sh",
    environment => ["PYTHON=${_tmp_venv}/bin/python"],
    require     => [
      File[$config_file],
      Service['redis'],
      Service["postgresql-${database_version}"]
    ],
    path        => '/usr/bin',
    cwd         => $software_directory_with_version,
    timeout     => 600,
    onlyif      => bool2str($run_update_script),
  }

  # Create symlink /opt/netbox/
  # We wait until the upgrade script completes successfully before
  # creating our symlink to the new folder
  #
  # If upgrade fails (in theory) the symlink should still be pointing
  # to older version and still be running
  file { $software_directory:
    ensure  => 'link',
    target  => $software_directory_with_version,
    owner   => $user,
    group   => $group,
    force   => true,
    require => Exec['upgrade script'],
  }

  if $log_dir_path and $log_file {
    exec { 'create log dir':
      command => "mkdir -p ${log_dir_path} && chown ${$user}:${$group} ${log_dir_path}",
      path    => '/usr/bin',
      require => File[$software_directory],
    }

    file { $_log_file_path:
      ensure  => file,
      owner   => $user,
      group   => $group,
      mode    => '0644',
      require => Exec['create log dir'],
    }
  }

  file { '/etc/cron.daily/netbox-housekeeping':
    ensure  => 'link',
    target  => "${software_directory}/contrib/netbox-housekeeping.sh",
    owner   => $user,
    group   => $group,
    require => File[$software_directory],
  }

  facter::fact { 'netbox_version_installed':
    value   => $version,
    require => Exec['upgrade script'],
  }
}
