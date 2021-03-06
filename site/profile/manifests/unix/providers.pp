class profile::unix::providers (
  $config   = undef,
) {
  if $config {
    $_config = $config
  }
  else {
    $_config = hiera_hash('profile::unix::providers', undef)
  }
  if $_config {
    if $config['host'] == 'augeas' {
      Host { provider => 'augeas' }
    }
    if $config['mailalias'] == 'augeas' {
      include augeasproviders
      Mailalias { provider => 'augeas' }
    }
    if $config['mounttab'] == 'augeas' {
      include augeasproviders
      Mounttab { provider => 'augeas' }
    }
  }
}
