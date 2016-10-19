class trav_mysql::install_mysql (
  $mysql_home,
  $package_name,
  $mysql_msi,
){
  $installer_file = "${mysql_home}\\${mysql_msi}"
  file { 'download mysql msi' :
    path => $installer_file,
    source => "puppet:///modules/trav_mysql/${mysql_msi}",
    require => File[$mysql_home],
  }

  package { $package_name :
    ensure => present,
    source => $installer_file,
    description => 'Installing mysql on ${::fqdn}',
    require => File['download mysql msi'],
    #install_options => ['INSTALLDIR=${mysql_home},/package','/quiet'],
  }

  exec { 'start mysql service' :
    command => 'bin\MySQLInstanceConfig.exe -i -q "-lC:\mysql_install_log.txt" » "-nMySQL Server 5.5" "-pC:\Program Files\MySQL\MySQL Server 5.5" -v5.5.3 »"-tmy-template.ini" "-cC:\mytest.ini" ServerType=DEVELOPMENT DatabaseType=MIXED » ConnectionUsage=DSS Port=3311 ServiceName=MySQL RootPassword=1234',
    cwd => "${mysql_home}\MySQL Server 5.5",
    #path => "${mysql_home}\MySQL Server 5.5\bin",
    provider => powershell,
    require => Package[$package_name]
  }

  service { 'MySQL' :
    ensure => 'running',
    require => Exec['start mysql service'],
  }

  windows_env { 'MYSQL_HOME':
    ensure => present,
    value => "${mysql_home}\MySQL Server 5.5",
  }

  windows_env{ 'PATH=%MYSQL_HOME%\bin': }

}