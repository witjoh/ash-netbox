# @summary Installs Netbox
#
# Installs Netbox
#
# @param install_root
#   The directory where the netbox installation is unpacked
#
# @param version
#   The version of Netbox. This must match the version in the
#   tarball. This is used for managing files, directories and paths in
#   the service.
#
# @param download_url
#   Where to download the binary installation tarball from.
#
# @param download_tmp_dir
#   Temporary directory for downloading the tarball.
#
# @param user
#   The user owning the Netbox installation files, and running the
#   service.
#
# @param group
#   The group owning the Netbox installation files, and running the
#   service.
#
# @example
#   include netbox::download
class netbox::download (
  Stdlib::Absolutepath $install_root,
  String $version,
  String $download_url,
  Stdlib::Absolutepath $download_tmp_dir,
  String $user,
  String $group,
  Boolean $include_ldap,
) {

  $packages =[
    gcc,
    python38,
    python38-devel,
    libxml2-devel,
    libxslt-devel,
    libffi-devel,
    openssl-devel,
    redhat-rpm-config
  ]

  $local_tarball = "${download_tmp_dir}/netbox-${version}.tar.gz"
  $software_directory_with_version = "${install_root}/netbox-${version}"
  $software_directory = "${install_root}/netbox"

  $ldap_packages = [openldap-devel]

  ensure_packages($packages)

  if $include_ldap {
    ensure_packages($ldap_packages)
  }

  user { $user:
    system => true,
    gid    => $group,
    home   => $software_directory,
  }

  group { $group:
    system => true,
  }

  # Download tarball to /tmp then extract tarball into $install_root
  archive { $local_tarball:
    source       => $download_url,
    extract      => true,
    extract_path => $install_root,
    cleanup      => true,
    before       => File[$software_directory_with_version],
  }

    # Create the dir netbox will be installed into
  file { $software_directory_with_version:
    ensure => directory,
    owner  => $user,
    group  => $group,
    # recurse => true,
    before => File[$software_directory],
  }

  # Create symlink /opt/netbox/
  file { $software_directory:
    ensure => 'link',
    target => $software_directory_with_version,
    owner  => $user,
    group  => $group,
  }
}
