class profile::unix::os::redhat::yumgroups (
  $config   = undef,
  $schedule = $::profile::unix::schedule,
) {
  $defaults = {
    ensure   => 'present',
    schedule => $schedule,
  }
  if $config {
    create_resources('profile::unix::os::redhat::yumgroup', $config, $defaults)
  }
  else {
    $hiera_config = hiera_hash('profile::unix::os::redhat::yumgroups', undef)
    if $hiera_config {
      create_resources('profile::unix::os::redhat::yumgroup', $hiera_config, $defaults)
    }
  }
}
