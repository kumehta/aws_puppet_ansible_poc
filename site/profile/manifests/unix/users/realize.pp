class profile::unix::users::realize (
  $users    = undef,
  $schedule = $::profile::unix::schedule,
) {
  if $users {
    realize(User[$users])
  }
  else {
    $hiera_users = hiera_array('profile::unix::users::realize', undef)
    if $hiera_users {
      realize(User[$hiera_users])
    }
  }
}
