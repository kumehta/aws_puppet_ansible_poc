class profile::unix::os::redhat::sysctl (
  $config   = undef,
  $schedule = $::profile::unix::schedule,
) {
  $defaults = {
    schedule => $schedule,
  }
  if $config {
    create_resources(sysctl, $config, $defaults)
  }
  else {
    $hiera_config = hiera_hash('profile::unix::os::redhat::sysctl', undef)
    if $hiera_config {
      create_resources(sysctl, $hiera_config, $defaults)
    }
  }
}
