class profile::unix::files (
  $config   = undef,
  $schedule = $::profile::unix::schedule,
) {
  $defaults = {
    ensure   => 'present',
    schedule => $schedule,
  }
  if $config {
    create_resources(file, $config, $defaults)
  }
  else {
    $hiera_config = hiera_hash('profile::unix::files', undef)
    if $hiera_config {
      create_resources(file, $hiera_config, $defaults)
    }
  }
}
