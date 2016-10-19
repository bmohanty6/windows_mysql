#
# Full description of class windows_mysql here.
#
# Parameters
# ----------
#
# Document parameters here.
#
# * `sample parameter`
# Explanation of what this parameter affects and what it defaults to.
# e.g. "Specify one or more upstream ntp servers as an array."
#
# Variables
# ----------
#
# Here you should define a list of variables that this module would require.
#
# * `sample variable`
#  Explanation of how this variable affects the function of this class and if
#  it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#  External Node Classifier as a comma separated list of hostnames." (Note,
#  global variables should be avoided in favor of class parameters as
#  of Puppet 2.6.)
#
# Examples
# --------
#
# @example
#    class { 'windows_mysql':
#      servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#    }
#
# Authors
# -------
#
# Author Name <author@domain.com>
#
# Copyright
# ---------
#
# Copyright 2016 Your name here, unless otherwise noted.
#
class windows_mysql {
  $mysql_home = "C:\Program Files\MySQL",
  $mysql_package = "mysql",
  $mysql_msi = "mysql-5.5.53-winx64.msi",
  $workbench_package = "mysql-workbench-community",
  $workbench_msi = "mysql-workbench-community-6.3.7-winx64.msi"
){

  file { $mysql_home :
    ensure => 'directory',
  }

  class { 'windows_mysql::install_mysql' :
    mysql_home => $mysql_home,
    package_name => $mysql_package,
    mysql_msi => $mysql_msi
  }

  class { 'windows_mysql::install_mysql_workbench' :
    mysql_home => $mysql_home,
    package_name => $workbench_package,
    workbench_msi => $workbench_msi
  }
}
