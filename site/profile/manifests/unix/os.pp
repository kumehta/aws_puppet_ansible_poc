class profile::unix::os {
  case $facts['operatingsystem'] {
    'AIX':     { include ::profile::unix::os::aix }
    'CentOS':  { include ::profile::unix::os::redhat }
    'RedHat':  { include ::profile::unix::os::redhat }
    'Solaris': { include ::profile::unix::os::sunos }
  }
}
