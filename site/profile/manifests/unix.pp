# -----------------------------------------------------------------------------
# Author  = Various - Based on 'Puppetlabs/System' by Keith Burdis
# Date    = 2018/03/06
# Version = 1.0 'unix.pp'
# Purpose = This is the 'unix' profile.
# -----------------------------------------------------------------------------

class profile::unix (
  $config   = {},
  $schedule = undef,
) {

  # Ensure that files and directories are created before
  # other resources (like mounts) that may depend on them
  if ! defined(Stage['third']) {
    stage { 'third': before => Stage['main'] }
  }

  # Ensure packages, users and groups are created
  # before other resources that may depend on them
  if ! defined(Stage['second']) {
    stage { 'second': before => Stage['third'] }
  }

  # Ensure providers are set before resources are created
  if ! defined(Stage['first']) {
    stage { 'first':  before => Stage['second'] }
  }

  # Things to do last because they depend on lots of other resources
  if ! defined(Stage['last']) {
    stage { 'last': require => Stage['main'] }
  }

  class { '::profile::unix::augeas':
    config => $config['augeas'],
  }

  class { '::profile::unix::crontabs':
    config => $config['crontabs'],
  }

  class { '::profile::unix::execs':
    config => $config['execs'],
    stage  => last,
  }

  class { '::profile::unix::facts':
    config => $config['facts'],
  }

  class { '::profile::unix::files':
    config => $config['files'],
    stage  => third,
  }

  class { '::profile::unix::groups':
    config => $config['groups'],
    stage  => second
  }

  class { '::profile::unix::groups::realize':
    groups  => $config['realize_groups'],
    stage   => second,
    require => Class['::profile::unix::groups'],
  }

  class { '::profile::unix::hosts':
    config => $config['hosts'],
  }

  class { '::profile::unix::mounts':
    config => $config['mounts'],
    stage  => last,
  }

  include '::profile::unix::os'
  include '::profile::unix::network'

  class { '::profile::unix::schedules':
    config => $config['schedules'],
    stage  => first,
  }

  class { '::profile::unix::selbooleans':
    config => $config['selbooleana'],
    stage  => first,
  }

  class { '::profile::unix::sshd':
    config => $config['sshd'],
  }

  class { '::profile::unix::templates':
    config => $config['templates'],
    stage  => last,
  }

  class { '::profile::unix::users':
    config  => $config['users'],
    stage   => second,
    require => Class['::profile::unix::groups'],
  }

  class { '::profile::unix::users::realize':
    users   => $config['realize_users'],
    stage   => second,
    require => Class['::profile::unix::users', '::profile::unix::groups::realize'],
  }

  class { '::profile::unix::providers':
    config => $config['providers'],
    stage  => first
  }
}

# -----------------------------------------------------------------------------
# End of file.
# -----------------------------------------------------------------------------
