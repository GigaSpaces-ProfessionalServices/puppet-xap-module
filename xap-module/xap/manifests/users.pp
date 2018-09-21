class xap::users (
  $user_name  = $xap::params::admin_name,
  $group_name = $xap::params::admin_group,
  $user_id    = $xap::params::admin_uid,
  $group_id   = $xap::params::admin_gid
) {

  group { $group_name:
    ensure => 'present',
    gid    => "${group_id}",
  }

  user { $user_name:
    ensure => 'present',
    gid => "${group_id}",
    home => "/home/${user_name}",
    uid => "${user_id}",
    managehome => true,
  }

  file { "/home/${user_name}":
    ensure => 'directory',
    group => "${group_id}",
    mode => '0700',
    owner => "${group_id}",
  }

}
