# -----------------------------------------------------------------------------
# Author  = Various - Based on PuppetLabs 'Roles & Profiles' by Craig Dunn
# Date    = 2018/03/06
# Version = 1.0 'common.pp'
# Purpose = This is the 'common' profile.
# -----------------------------------------------------------------------------

class profile::common {

  # Assign the PuppetLabs 'Stdlib' module and note the following stages:
  #
  #  stage { 'setup':        before  => Stage['main']         }
  #  stage { 'runtime':      require => Stage['main']         }
  #  stage { 'setup_infra':  require => Stage['runtime']      }
  #  stage { 'deploy_infra': require => Stage['setup_infra']  }
  #  stage { 'setup_app':    require => Stage['deploy_infra'] }
  #  stage { 'deploy_app':   require => Stage['setup_app']    }
  #  stage { 'deploy':       require => Stage['deploy_app']   }
  class { stdlib: }

  # Include the PuppetLabs 'Logical Volume Manager' module and assign to stage
  # 'first' in order to have logical volumes/filesystems created and mounted
  # before packages are installed.
  class { lvm: stage => 'setup_infra' }

}

# -----------------------------------------------------------------------------
# End of file.
# -----------------------------------------------------------------------------
