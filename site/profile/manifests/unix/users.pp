class profile::unix::users (
  $config   = undef,
  $schedule = $::profile::unix::schedule,
  $real     = false,
) {
  $defaults = {
    ensure   => 'present',
    schedule => $schedule,
    shell    => '/bin/bash'
  }
  if $real {
    $type = 'user'
  }
  else {
    $type = '@user'
  }
  if $config {
    system_create_resources($type, $config, $defaults)
  }
  else {
    $hiera_config = hiera_hash('profile::unix::users', undef)
    if $hiera_config {
      system_create_resources($type, $hiera_config, $defaults)
    }
  }
}
