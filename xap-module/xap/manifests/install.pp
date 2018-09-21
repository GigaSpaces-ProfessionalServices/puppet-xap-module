class xap::install (
  $install_dir     = $xap::params::install_dir,
  $owner_name      = $xap::params::admin_name,
  $owner_group     = $xap::params::admin_group,
  $xap_version     = $xap::params::xap_version,
  $xap_license     = $xap::params::xap_license,
  $lookup_locators = $xap::params::hostnames,
) {

  file { "/opt/downloads/$xap_version.zip":
    ensure => present,
    source => $package_source,
    group  => $owner_group,
    owner  => $owner_name,
    mode   => '0755',
  }

  file { $install_dir:
    ensure => directory,
    group  => $owner_group,
    mode   => '0755',
    owner  => $owner_name,
    notify => Exec['extract xap']
  }

  exec { "extract xap":
    command     => "/usr/bin/unzip /opt/downloads/$xap_version.zip",
    user        => $owner_name,
    cwd         => $install_dir,
    creates     => "$install_dir/$xap_version",
    refreshonly => true,
  }

  file { "$install_dir/$xap_version/xap-license.txt":
    ensure  => file,
    content => $xap_license,
    group   => $owner_group,
    owner   => $owner_name,
  }

  $directories = [
    "$install_dir/deploy",
    "$install_dir/scripts",
    "$install_dir/logs",
    "$install_dir/work"
  ]

  $directories.each |$directory| {
    file { $directory:
      ensure  => 'directory',
      group   => $owner_group,
      mode    => '0775',
      owner   => $owner_user,
      recurse => true
    }
  }

}
