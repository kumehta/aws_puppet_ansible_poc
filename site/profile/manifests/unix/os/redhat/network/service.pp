class profile::unix::network::redhat::service {
  service { 'network':
    ensure => 'running',
    enable => true,
  }
}
