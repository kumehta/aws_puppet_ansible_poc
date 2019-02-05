define profile::unix::network::redhat::route (
  $interface,
  $via,
) {
  $to = $title
  validate_string($to)
  validate_string($interface)
  if ! is_ip_address($via) {
    fail('profile::unix::network::redhat::route::via must be an IP address')
  }
  concat::fragment { "route-${interface}-${to}":
    target  => "/etc/sysconfig/network-scripts/route-${interface}",
    content => template('system/network/route.erb'),
    #notify  => Class['profile::unix::network::redhat::service'],
  }
}
