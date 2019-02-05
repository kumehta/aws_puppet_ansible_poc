class profile::unix::hosts (
  $config   = undef,
  $schedule = $::profile::unix::schedule,
) {
  $defaults = {
    ensure   => 'present',
    schedule => $schedule,
  }
  if $config {
    create_resources(host, $config, $defaults)
  }
  else {
    $hiera_config = hiera_hash('profile::unix::hosts', undef)
    if $hiera_config {
      create_resources(host, $hiera_config, $defaults)
    }
  }
}
