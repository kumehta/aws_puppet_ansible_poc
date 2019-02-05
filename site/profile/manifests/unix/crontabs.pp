class profile::unix::crontabs (
  $config   = undef,
  $schedule = $::profile::unix::schedule,
) {
  $defaults = {
    ensure   => 'present',
    schedule => $schedule,
    user     => 'root',
  }
  if $config {
    create_resources(cron, $config, $defaults)
  }
  else {
    $hiera_config = hiera_hash('profile::unix::crontabs', undef)
    if $hiera_config {
      create_resources(cron, $hiera_config, $defaults)
    }
  }
}
