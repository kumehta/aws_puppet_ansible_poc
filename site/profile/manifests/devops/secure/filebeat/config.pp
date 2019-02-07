# -----------------------------------------------------------------------------
# Author  = Kunal Mehta
# Date    = 2019/01/30
# Version = 1.0 'filebeat/config.pp'
# Purpose = This is the
#           'filebeat/config' profile.
#
# -----------------------------------------------------------------------------

class profile::devops::secure::filebeat::config (
  $config = undef,
  String $filebeat_owner,
  String $filebeat_group,
  String $filebeat_config_file,
  String $log_dir,
  String $init_service_template,
) {

  # Set the global execution path_
  Exec { path => ['/sbin', '/bin', '/usr/sbin', '/usr/bin'] }

  $banner='# Elements of this file are managed by Puppet.'

  # Patch the filebeat server configuration file.
  file { "${filebeat_config_file}":
    ensure  => file,
    owner   => "0",
    group   => "0",
    mode    => "0644",
  } ->
  exec { "${filebeat_config_file}":
    command => "sed -i '1s/^/#${banner}\\n\\n/' ${filebeat_config_file}",
    unless  => "grep '${banner}' ${filebeat_config_file}",
  } ->
  file {"/usr/lib/systemd/system/filebeat.service":
    mode    => '644',
    owner   => root,
    group   => root,
    backup  => false,
    content => template($init_service_template),
  } ->
  exec { "Enable filebeat":
    command => 'systemctl daemon-reload ; systemctl enable filebeat',
    unless  => 'test -f /usr/lib/systemd/system/filebeat.service',
  } ->
  service { "(Re)start filebeat":
    name      => "filebeat",
    enable    => true,
    ensure    => running,
    subscribe => File["${filebeat_config_file}"],
  }
}

# -----------------------------------------------------------------------------
# End of file.
# -----------------------------------------------------------------------------
