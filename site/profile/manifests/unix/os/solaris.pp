class profile::unix::os::solaris (
  $config   = {},
  $schedule = undef,
) {
  include '::profile::unix::os::solaris::network'
}
