class profile::unix::os::redhat::sysconfig (
  $config   = {},
  $schedule = $::profile::unix::schedule,
) {
  class { '::profile::unix::os::redhat::sysconfig::clock':
    config   => $config['clock'],
    schedule => $schedule,
  }

  class { '::profile::unix::os::redhat::sysconfig::i18n':
    config   => $config['i18n'],
    schedule => $schedule,
  }

  class { '::profile::unix::os::redhat::sysconfig::keyboard':
    config   => $config['keyboard'],
    schedule => $schedule,
  }

  class { '::profile::unix::os::redhat::sysconfig::puppetdashboard':
    config   => $config['puppetdashboard'],
    schedule => $schedule,
  }

  class { '::profile::unix::os::redhat::sysconfig::puppetmaster':
    config   => $config['puppetmaster'],
    schedule => $schedule,
  }

  class { '::profile::unix::os::redhat::sysconfig::puppet':
    config   => $config['puppet'],
    schedule => $schedule,
  }

  class { '::profile::unix::os::redhat::sysconfig::selinux':
    config   => $config['selinux'],
    schedule => $schedule,
  }
}
