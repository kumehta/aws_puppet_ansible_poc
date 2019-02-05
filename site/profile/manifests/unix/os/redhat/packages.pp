class profile::unix::os::redhat::packages (
  $config   = undef,
  $schedule = $::profile::unix::schedule,
) {
  $defaults = {
    ensure   => 'installed',
    schedule => $schedule,
  }
  if $config {
    create_resources(package, $config, $defaults)
  }
  else {
    $hiera_config = hiera_hash('profile::unix::os::redhat::packages', undef)
    if $hiera_config {
      create_resources(package, $hiera_config, $defaults)
    }
  }
}
