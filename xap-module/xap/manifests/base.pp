class xap::base (
  $java_package = $xap::params::package_jdk  
) {

  # install required packages
  $packages = [
    'xorg-x11-utils',
    'xorg-x11-xauth',
    'xorg-x11-fonts-Type1',
    'xorg-x11-apps',
    'unzip',
    'vim-enhanced',
    'nano',
    'sysstat',
    'net-tools',
    'iproute',
    'nc',
    $java_package
  ]

  package { $packages:
    ensure => 'latest'
  }
  
}
