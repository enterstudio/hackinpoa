class tsuruio::docker::fw_post inherits tsuruio::docker::params {

  firewall { '999 drop all to docker port':
    chain   => 'INPUT',
    proto   => 'tcp',
    dport   => $tsuruio::docker::params::docker_port,
    action  => 'drop',
    before  => undef,
  }

}
