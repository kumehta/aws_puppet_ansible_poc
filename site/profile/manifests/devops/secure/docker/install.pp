# -----------------------------------------------------------------------------
# Author  = Kunal Mehta
# Date    =
# Version = 1.0 'docker/install.pp'
# Purpose = This is the 'docker/install' profile.
#
# Mandatory hieradata fields:-
#
#  profile::generic::docker::install::git_repo:      MISCELLANEOUS
#  profile::generic::docker::install::packages:
#    - container-selinux-2.68-1.el7.noarch.rpm
#    - docker-ce-18.06.1.ce-3.el7.x86_64.rpm
#
# Optional hieradata fields:-
#
#  profile::generic::docker::install::git_software_repo:  SOFTWARE-RHEL
#  profile::generic::docker::install::files:
#    - docker-compose-1.22.0-Linux-x86_64.bin
#
# -----------------------------------------------------------------------------

class profile::generic::docker::install (
  String  $nexus_repo,
  Array   $packages,
) {

  # Set the global execution path.
  Exec { path => ['/sbin', '/bin', '/usr/sbin', '/usr/bin'] }

  # Lookup external profile variables.
  $owner = lookup('profile::generic::docker::config::owner', String, deep)
  $group = lookup('profile::generic::docker::config::group', String, deep)

  # Lookup optional profile variables.
  $git_software_repo = lookup('profile::generic::docker::install::nexus_software', String, deep)
  $files = lookup('profile::generic::docker::install::files', Array, deep, "")

  # Install specified packages.
  $packages.each | String $package | {

    # Determine short package name.
    $a = split($package,'-[0-9]+[\.]+')
    $package_name = $a[0]

    # Determine version to be installed.
    $b = $package.match(/[0-9]+[\.]+[0-9]+/)
    $package_version = $b[0]

    # Check if the package is already installed.
    exec { "$package_name":
      command   => "true",
      onlyif    => "rpm -qa | grep '^${package_name}-${package_version}' | wc -l | grep -w 0",
    }
    package { "$package_name":
      ensure    => installed,
      provider  => rpm,
      source    => "${nexus_server}/${nexus_repo}/${package}",
      subscribe => Exec["${package_name}"],
    }
  }

  # Install specified files.
  $files.each | String $file | {

    # Determine short file name.
    $a = split($file,'-[0-9]+[\.]+')
    $file_name = $a[0]

    # Check if the file is already installed.
    exec { "$file_name":
      command   => "true",
      onlyif    => "ls -l /usr/local/bin/${file_name} 2>/dev/null | wc -l | grep -w 0",
    }
    file { "/usr/local/bin/${file_name}":
      ensure    => file,
      owner     => "$owner",
      group     => "$group",
      mode      => "0555",
      source    => "${nexus_server}/${nexus_software}/${file}",
      subscribe => Exec["${file_name}"],
    }
  }

}

# -----------------------------------------------------------------------------
# End of file.
# -----------------------------------------------------------------------------
