define profile::unix::os::redhat::limits::set (
  $domain,
  $item,
  $soft = undef,
  $hard = undef
) {
  if $soft {
    profile::unix::os::redhat::limits::entry { "${domain}-soft-${item}":
      domain => $domain,
      type   => 'soft',
      item   => $item,
      value  => $soft,
    }
  }
  if $hard {
    profile::unix::os::redhat::limits::entry { "${domain}-hard-${item}":
      domain => $domain,
      type   => 'hard',
      item   => $item,
      value  => $hard,
    }
  }
}
