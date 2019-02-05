class profile::unix::schedules (
  $config = undef,
) {
  $defaults = {}
  if $config {
    create_resources(schedule, $config, $defaults)
  }
  else {
    $hiera_config = hiera_hash('profile::unix::schedules', undef)
    if $hiera_config {
      create_resources(schedule, $hiera_config, $defaults)
    }
  }
  schedule { 'always':
    range => '0 - 23',
  }
}
