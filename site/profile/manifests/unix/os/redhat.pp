class profile::unix::os::redhat (
  $config   = {},
  $schedule = undef,
) {

  include '::profile::unix::os::redhat::network'

  class { '::profile::unix::os::redhat::limits':
    config => $config['limits'],
  }

  class { '::profile::unix::os::redhat::mail':
    config => $config['mail'],
  }

  class { '::profile::unix::os::redhat::packages':
    config  => $config['packages'],
    stage   => second,
    require => Class['::profile::unix::os::redhat::yumgroups'],
  }

  class { '::profile::unix::os::redhat::services':
    config => $config['services'],
  }

  class { '::profile::unix::os::redhat::sysconfig':
    config => $config['sysconfig'],
  }

  class { '::profile::unix::os::redhat::sysctl':
    config => $config['sysctl'],
  }

  class { '::profile::unix::os::redhat::yumgroups':
    config => $config['yumgroups'],
    stage  => second,
  }

  class { '::profile::unix::os::redhat::yumrepos':
    config  => $config['yumrepos'],
    stage   => first,
    require => Class['::profile::unix::schedules'],
  }

}
