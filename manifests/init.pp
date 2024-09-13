# @summary Manage Netbox
#
# Install, configure and run Netbox
#
# @param version
#   The version of Netbox. This must match the version in the
#   tarball. This is used for managing files, directories and paths in
#   the service.
#
# @param user
#   The user owning the Netbox installation files, and running the
#   service.
#
# @param group [String]
#   The group owning the Netbox installation files, and running the
#   service.
#
# @param secret_key [String]
#   A random string of letters, numbers and symbols that Netbox needs.
#   This needs to be supplied, and should be treated as a secret. Should
#   be at least 50 characters long.
#
# @param download_url
#   Where to download the binary installation tarball from.
#
# @param download_checksum
#   The expected checksum of the downloaded tarball. This is used for
#   verifying the integrity of the downloaded tarball.
#
# @param download_checksum_type
#   The checksum type of the downloaded tarball. This is used for
#   verifying the integrity of the downloaded tarball.
#
# @param download_tmp_dir
#   Temporary directory for downloading the tarball.
#
# @param install_root
#   The directory where the netbox installation is unpacked
#
# @param handle_database
#   Should the PostgreSQL database be handled by this module.
#
# @param include_napalm
#   NAPALM allows NetBox to fetch live data from devices and return it to a requester via its REST API.
#   Installation of NAPALM is optional. To enable it, set $include_napalm to true
#
# @param include_django_storages
#   By default, NetBox will use the local filesystem to storage uploaded files.
#   To use a remote filesystem, install the django-storages library and configure your desired backend in configuration.py.
#
# @param include_ldap
#   Makes sure the packages and the python modules needed for LDAP-authentication are installed and loaded.
#   The LDAP-config itself is not handled by this Puppet module at present.
#   Use the documentation found here: https://netbox.readthedocs.io/en/stable/installation/5-ldap/ for information about
#   the config file.
#
# @param email_server
#   Host name or IP address of the email server (use localhost if running locally)
#   https://netbox.readthedocs.io/en/stable/configuration/optional-settings/#email
#
# @param email_timeout
#   Amount of time to wait for a connection (seconds)
#   https://netbox.readthedocs.io/en/stable/configuration/optional-settings/#email
#
# @param email_port
#   TCP port to use for the connection (default: 25)
#   https://netbox.readthedocs.io/en/stable/configuration/optional-settings/#email
#
# @param email_username
#   Username with which to authenticate
#   https://netbox.readthedocs.io/en/stable/configuration/optional-settings/#email
#
# @param email_password
#   Password with which to authenticate
#   https://netbox.readthedocs.io/en/stable/configuration/optional-settings/#email
#
# @param email_from_email
#   Sender address for emails sent by NetBox
#   https://netbox.readthedocs.io/en/stable/configuration/optional-settings/#email
#
# @param handle_redis
#   Should the Redis installation be handled by this module. Defaults to true.
#
# @param database_name
#   Name of the PostgreSQL database. If handle_database is true, then this database
#   gets created as well. If not, then it is only used by the application, and needs to exist.
#   Defaults to 'netbox'
#
# @param database_user
#   Name of the PostgreSQL database user. If handle_database is true, then this database user
#   gets created as well. If not, then it is only used by the application, and needs to exist.
#   Defaults to 'netbox'
#
# @param database_password
#   Name of the PostgreSQL database password. If handle_database is true, then this database password
#   gets created as well. If not, then it is only used by the application, and needs to exist.
#   Defaults to 'netbox'
#
# @param database_encoding
#   Encoding of the PostgreSQL database. If handle_database is false, this does nothing.
#   Defaults to 'UTF-8'
#
# @param database_locale
#   Locale of the PostgreSQL database. If handle_database is false, this does nothing.
#   Defaults to 'en_US.UTF-8''
#
# @param database_version
#   Version of postgres to use
#
# @param database_host
#   Name of the PostgreSQL database host. Defaults to 'localhost'
#
# @param database_port
#   PostgreSQL database port. NB! The PostgreSQL database that is made when using handle_database
#   does not support configuring a non-standard port. So change this parameter only if using
#   separate PostgreSQL DB with non-standard port. Defaults to 5432.
#
# @param database_conn_max_age
#   Database max connection age in seconds. Defaults to 300.
#
# @param allowed_hosts
#   Array of valid fully-qualified domain names (FQDNs) for the NetBox server. NetBox will not permit write
#   access to the server via any other hostnames. The first FQDN in the list will be treated as the preferred name.
#
# @param banner_top
#   Text for top banner on the Netbox webapp
#   Defaults to the empty string
#
# @param banner_bottom
#   Text for bottom banner on the Netbox webapp
#   Defaults to the empty string
#
# @param banner_login
#   Text for login banner on the Netbox webapp
#   Defaults to the empty string
#
# @param base_path
#   Base URL path if accessing NetBox within a directory.
#   For example, if installed at http://example.com/netbox/, set: BASE_PATH = 'netbox/'
#
# @param admins
#   Array of hashes with two keys, 'name' and 'email'. This is where the email goes if something goes wrong
#   This feature (in the Puppet module) is not well tested.
#
# @param debug
#   Set to True to enable server debugging. WARNING: Debugging introduces a substantial performance penalty and may reveal
#   sensitive information about your installation. Only enable debugging while performing testing. Never enable debugging
#   on a production system.
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
# @param enforce_global_unique
#   Enforcement of unique IP space can be toggled on a per-VRF basis. To enforce unique IP space within the global table
#   (all prefixes and IP addresses not assigned to a VRF), set ENFORCE_GLOBAL_UNIQUE to True.
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
#   Time zone
#
# @param date_format
#   Date/time formatting. See the following link for supported formats:
#   https://docs.djangoproject.com/en/stable/ref/templates/builtins/#date
#
# @param short_date_format
#   Date/time formatting. See the following link for supported formats:
#   https://docs.djangoproject.com/en/stable/ref/templates/builtins/#date
#
# @param time_format
#   Date/time formatting. See the following link for supported formats:
#   https://docs.djangoproject.com/en/stable/ref/templates/builtins/#date
#
# @param short_time_format
#   Date/time formatting. See the following link for supported formats:
#   https://docs.djangoproject.com/en/stable/ref/templates/builtins/#date
#
# @param datetime_format
#   Date/time formatting. See the following link for supported formats:
#   https://docs.djangoproject.com/en/stable/ref/templates/builtins/#date
#
# @param short_datetime_format
#   Date/time formatting. See the following link for supported formats:
#   https://docs.djangoproject.com/en/stable/ref/templates/builtins/#date
#
# @param python_version
#   Python version to use for netbox
#
# @param log_dir_path
#   Directory where log files are stored
#
# @param log_file
#   Name of log file to store logs
#
# @param log_file_max_bytes
#   Determines in bytes how big a log file can be before rotating
#
# @param num_of_log_backups
#   Determines number of log files to keep as backup
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
#   OU to seach when looking for netbox related CN's
#
# @param ldap_netbox_ro_user_cn
#   CN of netbox group for read only access
#
# @param ldap_netbox_admin_user_cn
#   CN of netbox group for admin access
#
# @param ldap_netbox_super_user_cn
#   CN of netbox group for super user access
#
# @example Defaults
#   class { 'netbox':
#     secret_key => $my_secret_variable
#   }
#
class netbox (
  String $secret_key,
  String $version = '3.4.6',
  String $download_url = "https://github.com/netbox-community/netbox/archive/refs/tags/v${version}.tar.gz",
  String $download_checksum = '505e4551f6420a70265e927a2ad7b2fabbea5d917e396abaf410713d80fd2736',
  Stdlib::Absolutepath $download_tmp_dir = '/tmp',
  String $user = 'netbox',
  String $group = 'netbox',
  String $download_checksum_type = 'sha256',
  Stdlib::Absolutepath $install_root = '/opt',
  Boolean $handle_database = true,
  Boolean $handle_redis = true,
  Boolean $include_napalm = true,
  Boolean $include_django_storages = true,
  Boolean $include_ldap = true,
  String $database_name       = 'netbox',
  String $database_user       = 'netbox',
  String $database_password   = 'netbox',
  String $database_encoding   = 'UTF-8',
  String $database_locale     = 'en_US.UTF-8',
  String $database_version    = '12',
  Stdlib::Host $database_host = 'localhost',
  Integer $database_port = 5432,
  Integer $database_conn_max_age = 300,
  Array[Stdlib::Host] $allowed_hosts = ['netbox.example.com','localhost', '127.0.0.1'],
  Optional[String] $banner_top = undef,
  Optional[String] $banner_bottom = undef,
  Optional[String] $banner_login = undef,
  Optional[String] $base_path = undef,
  Array $admins = [],
  Boolean $debug = false,
  Boolean $enforce_global_unique = false,
  Boolean $login_required = false,
  Boolean $metrics_enabled = false,
  Boolean $prefer_ipv4 = false,
  Array $exempt_view_permissions = [],
  Optional[String] $napalm_username = undef,
  Optional[String] $napalm_password = undef,
  Integer $napalm_timeout = 30,
  String $email_server = 'localhost',
  Integer $email_timeout = 10,
  Stdlib::Port $email_port = 25,
  Optional[String] $email_username = undef,
  Optional[String] $email_password = undef,
  Optional[String] $email_from_email = undef,
  String $time_zone = 'UTC',
  String $date_format = 'N j, Y',
  String $short_date_format = 'Y-m-d',
  String $time_format = 'g:i a',
  String $short_time_format = 'H:i:s',
  String $datetime_format = 'N j, Y g:i a',
  String $short_datetime_format = 'Y-m-d H:i',
  String $python_version = '3.8',
  Optional[Stdlib::Absolutepath] $log_dir_path = undef,
  Optional[String] $log_file = undef,
  Integer $log_file_max_bytes = 1024 * 500,
  Integer $num_of_log_backups = 5,

  # LDAP params
  Optional[String] $ldap_server = undef,
  Optional[String] $ldap_service_account_cn = undef,
  Optional[String] $ldap_service_account_password = undef,
  Optional[String] $ldap_service_account_ou = undef,
  Optional[String] $ldap_dc = undef,
  Optional[String] $ldap_netbox_group_ou = undef,
  Optional[String] $ldap_netbox_ro_user_cn = undef,
  Optional[String] $ldap_netbox_admin_user_cn = undef,
  Optional[String] $ldap_netbox_super_user_cn = undef,
) {
  Class['netbox::download'] -> Class['netbox::install'] ~> Class['netbox::service']

  if $handle_database {
    class { 'netbox::database':
      database_name     => $database_name,
      database_user     => $database_user,
      database_password => $database_password,
      database_encoding => $database_encoding,
      database_locale   => $database_locale,
      database_version  => $database_version,
      before            => Class['netbox::install'],
    }
    if $handle_redis {
      Class['netbox::database'] -> Class['netbox::redis']
    } else {
      Class['netbox::database'] -> Class['netbox::download']
    }
  }

  if $handle_redis {
    class { 'netbox::redis':
      before  => Class['netbox::install'],
      require => Class['netbox::download'],
    }
  }

  $_software_directory = "${install_root}/netbox"

  class { 'netbox::download':
    install_root       => $install_root,
    software_directory => $_software_directory,
    version            => $version,
    python_version     => $python_version,
    user               => $user,
    group              => $group,
    download_url       => $download_url,
    download_tmp_dir   => $download_tmp_dir,
    include_ldap       => $include_ldap,
  }

  $redis_options = {
    'tasks' => {
      host => 'localhost',
      port => 6379,
      password => '',
      database => 0,
      default_timeout => 300,
      ssl => 'False',
    },
    'caching' => {
      host => 'localhost',
      port => 6379,
      password => '',
      database => 1,
      default_timeout => 300,
      ssl => 'False',
    },
  }

  $email_options = {
    server     => $email_server,
    port       => $email_port,
    username   => $email_username,
    password   => $email_password,
    timeout    => $email_timeout,
    from_email => $email_from_email,
  }

  class { 'netbox::install':
    version                       => $version,
    software_directory            => $_software_directory,
    user                          => $user,
    group                         => $group,
    allowed_hosts                 => $allowed_hosts,
    database_name                 => $database_name,
    database_user                 => $database_user,
    database_password             => $database_password,
    database_host                 => $database_host,
    database_port                 => $database_port,
    database_conn_max_age         => $database_conn_max_age,
    redis_options                 => $redis_options,
    email_options                 => $email_options,
    secret_key                    => $secret_key,
    admins                        => $admins,
    banner_top                    => $banner_top,
    banner_bottom                 => $banner_bottom,
    banner_login                  => $banner_login,
    base_path                     => $base_path,
    debug                         => $debug,
    enforce_global_unique         => $enforce_global_unique,
    login_required                => $login_required,
    metrics_enabled               => $metrics_enabled,
    prefer_ipv4                   => $prefer_ipv4,
    exempt_view_permissions       => $exempt_view_permissions,
    napalm_username               => $napalm_username,
    napalm_password               => $napalm_password,
    napalm_timeout                => $napalm_timeout,
    time_zone                     => $time_zone,
    date_format                   => $date_format,
    short_date_format             => $short_date_format,
    time_format                   => $time_format,
    short_time_format             => $short_time_format,
    datetime_format               => $datetime_format,
    short_datetime_format         => $short_datetime_format,
    include_napalm                => $include_napalm,
    include_django_storages       => $include_django_storages,
    include_ldap                  => $include_ldap,
    python_version                => $python_version,
    log_dir_path                  => $log_dir_path,
    log_file                      => $log_file,

    # LDAP params
    ldap_server                   => $ldap_server,
    ldap_service_account_cn       => $ldap_service_account_cn,
    ldap_service_account_password => $ldap_service_account_password,
    ldap_service_account_ou       => $ldap_service_account_ou,
    ldap_dc                       => $ldap_dc,
    ldap_netbox_group_ou          => $ldap_netbox_group_ou,
    ldap_netbox_ro_user_cn        => $ldap_netbox_ro_user_cn,
    ldap_netbox_admin_user_cn     => $ldap_netbox_admin_user_cn,
    ldap_netbox_super_user_cn     => $ldap_netbox_super_user_cn,
  }

  class { 'netbox::service':
    software_directory => $_software_directory,
    user               => $user,
    group              => $group,
    restart_service    => $facts['netbox_version_installed'] != $version,
  }
}
