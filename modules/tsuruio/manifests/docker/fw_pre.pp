class tsuruio::docker::fw_pre inherits tsuruio::docker::params {

  Firewall {
    require => undef,
  }

  firewall { '001 accept docker from localhost':
    chain   => 'INPUT',
    proto   => 'tcp',
    iniface => 'lo',
    dport   => $tsuruio::docker::params::docker_port,
    action  => 'accept'
  }->
  firewall { '002 accept docker from tsuru api from sa-east-1a':
    chain   => 'INPUT',
    proto   => 'tcp',
    iniface => 'eth0',
    source  => '10.20.1.0/24',
    dport   => $tsuruio::docker::params::docker_port,
    action  => 'accept'
  }->
  firewall { '002 accept docker from tsuru api from sa-east-1b':
    chain   => 'INPUT',
    proto   => 'tcp',
    iniface => 'eth0',
    source  => '10.20.2.0/24',
    dport   => $tsuruio::docker::params::docker_port,
    action  => 'accept'
  }

}
