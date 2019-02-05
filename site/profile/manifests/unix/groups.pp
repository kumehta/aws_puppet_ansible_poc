class profile::unix::groups (
  $config   = undef,
  $schedule = $::profile::unix::schedule,
  $real     = false,
) {
  $defaults = {
    ensure   => 'present',
    schedule => $schedule,
  }
  if $real {
    $type = 'group'
  }
  else {
    $type = '@group'
  }
  if $config {
    system_create_resources($type, $config, $defaults)
  }
  else {
    $hiera_config = hiera_hash('profile::unix::groups', undef)
    if $hiera_config {
      system_create_resources($type, $hiera_config, $defaults)
    }
  }
}
