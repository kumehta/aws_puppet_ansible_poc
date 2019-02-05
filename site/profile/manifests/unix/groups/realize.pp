class profile::unix::groups::realize (
  $groups   = undef,
  $schedule = $::profile::unix::schedule,
) {
  if $groups {
    realize(Group[$groups])
  }
  else {
    $hiera_groups = hiera_array('profile::unix::groups::realize', undef)
    if $hiera_groups {
      realize(Group[$hiera_groups])
    }
  }
}
