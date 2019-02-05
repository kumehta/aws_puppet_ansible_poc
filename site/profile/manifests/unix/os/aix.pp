class profile::unix::os::aix (
  $config   = {},
  $schedule = undef,
) {
  include '::profile::unix::os::aix::network'
}
