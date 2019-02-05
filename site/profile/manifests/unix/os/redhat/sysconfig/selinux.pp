class profile::unix::os::redhat::sysconfig::selinux (
  $config   = undef,
  $schedule = undef,
) {
  if $config {
    $selinux = $config
  }
  else {
    $selinux = hiera_hash('profile::unix::os::redhat::sysconfig::selinux', undef)
  }
  if $selinux {
    profile::unix::os::redhat::sysconfig::header { 'selinux':
      schedule => $schedule,
    }
    profile::unix::os::redhat::sysconfig::entry { 'selinux-state':
      file     => 'selinux',
      var      => 'SELINUX',
      val      => $selinux['state'],
      schedule => $schedule,
    }
    profile::unix::os::redhat::sysconfig::entry { 'selinux-type':
      file     => 'selinux',
      var      => 'SELINUXTYPE',
      val      => $selinux['type'],
      schedule => $schedule,
    }
  }
}
