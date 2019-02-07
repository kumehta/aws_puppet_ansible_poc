# -----------------------------------------------------------------------------
# Author  = Kunal Mehta
# Date    =
# Version = 1.0 'docker/config.pp'
# Purpose = This is 'docker/config' profile.
#
# Mandatory hieradata fields:-
#
#  profile::generic::docker::config::owner:                docker
#  profile::generic::docker::config::group:                docker
#  profile::generic::docker::config::docker_dir:           /app/docker
#
# Optional hieradata fields:-
#
#  profile::generic::docker::config::firewalld_add_ports:
#    - '8080/tcp'
#
# -----------------------------------------------------------------------------

class profile::generic::docker::config (
  String  $owner,
  String  $group,
  String  $docker_dir,
){

  # Set the global execution path.
  Exec { path => ['/sbin', '/bin', '/usr/sbin', '/usr/bin',], }

  $banner='Elements of this file are managed by Puppet.'

  # Lookup optional profile variables.
  $firewalld_add_ports = lookup('profile::generic::docker::config::firewalld_add_ports', Array, deep, [])

  # Patch the Docker systemctl services file to change repository location.
  file { "/usr/lib/systemd/system/docker.service":
    ensure  => file,
    owner   => "0",
    group   => "0",
    mode    => "0644",
  } ->
  exec { "/usr/lib/systemd/system/docker.service":
    command => "sed -i '1s/^/# ${banner}\\n\\n/' /usr/lib/systemd/system/docker.service",
    unless  => "grep '# ${banner}' /usr/lib/systemd/system/docker.service",
  } ->
  file_line { "/usr/lib/systemd/system/docker.service - Repo":
    path    => "/usr/lib/systemd/system/docker.service",
    match   => "^ExecStart=/usr/bin/dockerd",
    line    => "ExecStart=/usr/bin/dockerd -g ${docker_dir}",
    replace => true,
    ensure  => present,
  }

  # Add specified ports to local firewall.
  # notify { "Firewalld is running: $firewalld": }
  if "$firewalld" == "true" {
    $firewalld_add_ports.each | String $add_port | {
      exec { "Firewall add port $add_port":
        command     => "firewall-cmd --permanent --zone=public --add-port $add_port",
        unless      => "firewall-cmd --permanent --zone=public --list-all | grep -qw '$add_port'",
      }
      exec { "Reload Firewall":
        command     => "firewall-cmd --reload",
        refreshonly => true,
        subscribe   => Exec["Firewall add port $add_port"],
      }
    }
  }

  # Enable Docker application and (re)start.
  exec { "Enable Docker":
    command   => 'systemctl daemon-reload ; systemctl enable docker',
    unless    => 'test -h /etc/systemd/system/multi-user.target.wants/docker.service',
  } ->
  service { "(Re)start Docker":
    name      => "docker",
    enable    => true,
    ensure    => running,
  }

}

# -----------------------------------------------------------------------------
# End of file.
# -----------------------------------------------------------------------------
