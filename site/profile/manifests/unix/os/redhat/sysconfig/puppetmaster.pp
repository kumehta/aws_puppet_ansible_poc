class profile::unix::os::redhat::sysconfig::puppetmaster (
  $config   = undef,
  $schedule = undef,
) {
  if $config {
    $puppetmaster = $config
  }
  else {
    $puppetmaster = hiera_hash('profile::unix::os::redhat::sysconfig::puppetmaster', undef)
  }
  if $puppetmaster {
    profile::unix::os::redhat::sysconfig::header { 'puppetmaster':
      schedule => $schedule,
    }
    profile::unix::os::redhat::sysconfig::entry { 'puppetmaster-manifest':
      file  => 'puppetmaster',
      var   => 'PUPPETMASTER_MANIFEST',
      val   => $puppetmaster['manifest'],
      schedule => $schedule,
    }
    profile::unix::os::redhat::sysconfig::entry { 'puppetmaster-ports':
      file  => 'puppetmaster',
      var   => 'PUPPETMASTER_PORTS',
      val   => $puppetmaster['ports'],
      schedule => $schedule,
    }
    profile::unix::os::redhat::sysconfig::entry { 'puppetmaster-log':
      file  => 'puppetmaster',
      var   => 'PUPPETMASTER_LOG',
      val   => $puppetmaster['log'],
      schedule => $schedule,
    }
    profile::unix::os::redhat::sysconfig::entry { 'puppetmaster-extra_opts':
      file  => 'puppetmaster',
      var   => 'PUPPETMASTER_EXTRA_OPTS',
      val   => $puppetmaster['extra_opts'],
      schedule => $schedule,
    }
  }
}
