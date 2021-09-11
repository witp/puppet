exec { 'newaliases':
  command     => '/usr/bin/newaliases',
  logoutput => on_failure,
}
