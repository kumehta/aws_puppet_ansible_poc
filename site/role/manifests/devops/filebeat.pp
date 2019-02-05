# -----------------------------------------------------------------------------
# Author  = Kunal Mehta
# Date    = 05/02/2019
# Version = 1.0 'filebeat.pp'
# Purpose = This is the 'filebeat' role.
#           Include feature profiles as required.
# -----------------------------------------------------------------------------

class role::devops::filebeat {

  # Assign the common and unix profiles first, then -> other profiles.
  class { profile::common: } ->
  class { profile::unix:   } ->

  # Assign filebeat application profiles.
  class { profile::devops::filebeat::install:    stage => 'setup_app'  }
  class { profile::devops::filebeat::config:     stage => 'deploy_app' }

}

# -----------------------------------------------------------------------------
# End of file.
