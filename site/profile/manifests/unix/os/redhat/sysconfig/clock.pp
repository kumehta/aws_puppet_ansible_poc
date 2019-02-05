class profile::unix::os::redhat::sysconfig::clock (
  $config   = undef,
  $schedule = undef,
) {
  if $config {
    $clock = $config
  }
  else {
    $clock = hiera_hash('profile::unix::os::redhat::sysconfig::clock', undef)
  }
  if $clock {
    $timezone = $clock['timezone']
    profile::unix::os::redhat::sysconfig::header { 'clock':
      schedule => $schedule,
    }
    profile::unix::os::redhat::sysconfig::entry { 'clock-zone':
      file     => 'clock',
      var      => 'ZONE',
      val      => $timezone,
      nudge    => Exec['/etc/localtime'],
      schedule => $schedule,
    }
    exec { '/etc/localtime':
      command     => "/bin/rm -f /etc/localtime && /bin/cp /usr/share/zoneinfo/${timezone} /etc/localtime",
      refreshonly => true,
      schedule    => $schedule,
    }
  }
}
