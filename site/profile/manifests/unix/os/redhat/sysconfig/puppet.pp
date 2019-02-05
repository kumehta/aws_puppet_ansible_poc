class profile::unix::os::redhat::sysconfig::puppet (
  $config   = undef,
  $schedule = undef,
) {
  if $config {
    $puppet = $config
  }
  else {
    $puppet = hiera_hash('profile::unix::os::redhat::sysconfig::puppet', undef)
  }
  if $puppet {
    profile::unix::os::redhat::sysconfig::header { 'puppet':
      schedule => $schedule,
    }
    profile::unix::os::redhat::sysconfig::entry { 'puppet-server':
      file  => 'puppet',
      var   => 'PUPPET_SERVER',
      val   => $puppet['server'],
      schedule => $schedule,
    }
    profile::unix::os::redhat::sysconfig::entry { 'puppet-port':
      file  => 'puppet',
      var   => 'PUPPET_PORT',
      val   => $puppet['port'],
      schedule => $schedule,
    }
    profile::unix::os::redhat::sysconfig::entry { 'puppet-log':
      file  => 'puppet',
      var   => 'PUPPET_LOG',
      val   => $puppet['log'],
      schedule => $schedule,
    }
    profile::unix::os::redhat::sysconfig::entry { 'puppet-extra_opts':
      file  => 'puppet',
      var   => 'PUPPET_EXTRA_OPTS',
      val   => $puppet['extra_opts'],
      schedule => $schedule,
    }
  }
}
