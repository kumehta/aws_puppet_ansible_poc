class profile::unix::selbooleans (
  $config   = undef,
  $schedule = $::profile::unix::schedule,
) {
  if $::selinux == true {
    $defaults = {
      schedule => $schedule,
    }
    if $config {
      create_resources(selboolean, $config, $defaults)
    }
    else {
      $hiera_config = hiera_hash('profile::unix::selbooleans', undef)
      if $hiera_config {
        create_resources(selboolean, $hiera_config, $defaults)
      }
    }
  }
}
