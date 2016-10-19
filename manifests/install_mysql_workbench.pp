class windows_mysql::install_mysql_workbench (
  $mysql_home,
  $package_name,
  $workbench_msi,
){
  $installer_file = "${mysql_home}\\${workbench_msi}"

  file { 'download mysql workbench msi' :
    path => $installer_file,
    source => "puppet:///modules/trav_mysql/${workbench_msi}",
    require => File[$mysql_home],
  }

  file { 'visualcplusplus exe':,
    ensure => present,
    path => "${mysql_home}\vcredist_x64.exe",
    source => 'puppet:///modules/trav_mysql/vcredist_x64.exe'
  }

  package { 'vcredist' :
    ensure => installed,
    source => "${mysql_home}\vcredist_x64.exe",
    require => File['visualcplusplus exe'],
    install_options => ['/S'],
  }

  package { $package_name :
    ensure => present,
    source => $installer_file,
    description => 'Installing mysql workbench on ${::fqdn}',
    require => Package['vcredist']
  }
}