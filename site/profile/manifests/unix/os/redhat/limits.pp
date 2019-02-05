class profile::unix::os::redhat::limits (
  $config    = undef,
  $use_hiera = true
) {
  if $use_hiera {
    $limits = hiera_hash('profile::unix::os::redhat::limits', $config)
  }
  else {
    $limits = $config
  }
  if $limits {
    create_resources( 'profile::unix::os::redhat::limits::domain', $limits )
  }
}

