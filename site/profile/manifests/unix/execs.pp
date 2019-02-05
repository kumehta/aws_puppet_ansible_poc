class profile::unix::execs (
  $config   = undef,
  $schedule = $::profile::unix::schedule,
) {
  $defaults = {
    schedule => $schedule,
  }
  if $config {
    create_resources(exec, $config, $defaults)
  }
  else {
    $hiera_config = hiera_hash('profile::unix::execs', undef)
    if $hiera_config {
      create_resources(exec, $hiera_config, $defaults)
    }
  }
}
