class xap::params(
  $admin_name,
  $admin_group,
  $admin_uid,
  $admin_gid,
  $install_dir,
  $log_dir,
  $manager_stabilization_delay,
  $gsc_creation_delay,
  $package_jdk,
  $xap_version,
  $xap_package_dir,
  $xap_manager_servers,
  $lookup_group,
  $lookup_locators,
  $unicast_port,
  $xap_mgr,
  $mgt_port,
  $xap_license,
  $common_java_options,
  $ext_java_options,
  $host_name,
  $node_type,
  $webui_execution,
  $zone_data_for_node
) {

  # notify { "install_dir is $install_dir": }
  # notify { "xap_version is $xap_version": }

}
