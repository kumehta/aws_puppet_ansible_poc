class profile::unix::os::redhat::services (
  $config   = undef,
  $schedule = $::profile::unix::schedule,
) {
  $defaults = {
    ensure     => 'running',
    hasrestart => true,
    hasstatus  => true,
    schedule   => $schedule,
  }
  if $config {
    create_resources(service, $config, $defaults)
  }
  else {
    $hiera_config = hiera_hash('profile::unix::os::redhat::services', undef)
    if $hiera_config {
      create_resources(service, $hiera_config, $defaults)
    }
  }
}
