class xap::scripts (
  $install_dir                     = $xap::params::install_dir,
  $log_dir                            = $xap::params::log_dir,
  $owner_user                         = $xap::params::admin_name,
  $owner_group                        = $xap::params::admin_group,
  $xap_version                        = $xap::params::xap_version,
  $lookup_group                       = $xap::params::lookup_group,
  $lookup_locators                    = $xap::params::lookup_locators,
  $xap_managers                       = $xap::params::xap_manager_servers,
  $unicast_port                       = $xap::params::unicast_port,
  $xap_mgr                            = $xap::params::xap_mgr,
  $mgt_port                           = $xap::params::mgt_port,
  $nic_address                        = $xap::params::host_name,
  $nodetype                           = $xap::params::node_type,
  $hostname                           = $xap::params::host_name,
  $runwebui                           = $xap::params::webui_execution,
  $zone_data                          = $xap::params::zone_data_for_node,
  $common_java_options                = $xap::params::common_java_options,
  $ext_java_options                   = $xap::params::ext_java_options,
  $manager_server_stabilization_delay = $xap::params::manager_server_stabilization_delay,
  $gsc_creation_delay                 = $xap::params::gsc_creation_delay,
  $env_vars            = [
      "XAP_HOME=$install_dir/$xap_version",
      "XAP_LOOKUP_LOCATORS=$lookup_locators",
      "XAP_LOOKUP_GROUPS=$lookup_group",
      "UNICAST_PORT=$unicast_port",
      "XAP_MANAGER_SERVERS=$xap_managers",
      "XAP_NIC_ADDRESS=$nic_address"
  ],
) {

  $xap_home = "$install_dir/$xap_version";

  if $nodetype == 'manager' {

    file { "$install_dir/scripts/xap-mgr.sh":
      ensure  => present,
      content => template('xap/xapmgr.erb'),
      group   => $owner_group,
      owner   => $owner_user,
      mode    => '0775',
      notify  => Exec['run xap-mgr.sh'],
    }

    exec { "run xap-mgr.sh": 
      environment => $env_vars,
      command     => '/bin/bash -x xap-mgr.sh',
      cwd         => "$install_dir/scripts",
      user        => $owner_user,
      timeout     => 0,
      refreshonly => true,
      logoutput   => true,
    }

  } else {

    file { "$install_dir/scripts/xap-non-mgr.sh":
      ensure  => present,
      content => template('xap/xapnonmgr.erb'),
      group   => $owner_group,
      owner   => $owner_user,
      mode    => '0775',
      notify  => Exec['run xap-non-mgr.sh'],
    }

    exec { "run xap-non-mgr.sh": 
      environment => $env_vars,
      command     => '/bin/bash -x xap-non-mgr.sh',
      cwd         => "$install_dir/scripts",
      user        => $owner_user,
      timeout     => 0,
      refreshonly => true,
      logoutput   => true,
    }

  }

  file { "$install_dir/scripts/gs-agent-zone.sh":
    ensure  => present,
    content => template('xap/agentzone.erb'),
    group   => $owner_group,
    owner   => $owner_user,
    mode    => '0775',
    notify  => Exec['sanitize gs-agent-zone.sh'],
  }

  exec { "sanitize gs-agent-zone.sh":
    environment => $env_vars,
    command     => "/bin/sed -i '/^\\s*$/d' gs-agent-zone.sh",
    cwd         => "$install_dir/scripts",
    user        => $owner_user,
    timeout     => 0,
    logoutput   => true,
    notify  => Exec['run gs-agent-zone.sh'],
  }

  exec { "run gs-agent-zone.sh":
    environment => $env_vars,
    command     => "/bin/bash -x gs-agent-zone.sh",
    cwd         => "$install_dir/scripts",
    user        => $owner_user,
    timeout     => 0,
    refreshonly => true,
    logoutput   => true,
  }

  if $runwebui {

    file { "$install_dir/scripts/gs-webui.sh":
      ensure  => present,
      content => template('xap/webui.erb'),
      group   => $owner_group,
      owner   => $owner_user,
      mode    => '0775',
      notify  => Exec['run gs-webui.sh'],
    }
  
    exec { "run gs-webui.sh":
      environment => $env_vars,
      command     => '/bin/bash -x gs-webui.sh',
      cwd         => "$install_dir/scripts",
      user        => $owner_user,
      timeout     => 0,
      refreshonly => true,
    }

  }

}
