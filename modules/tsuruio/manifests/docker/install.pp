class tsuruio::docker::install inherits tsuruio::docker::params {

  require ::base

  # Docker firewall
  resources { 'firewall':
    purge => false
  }

  Firewall {
    before  => Class['tsuruio::docker::fw_post'],
    require => Class['tsuruio::docker::fw_pre'],
  }

  class { ['tsuruio::docker::fw_pre', 'tsuruio::docker::fw_post']: }

  class { '::firewall': }

  class { '::docker':
    lxc_docker_version           => $tsuruio::docker::params::lxc_docker_version,
    docker_graph_dir             => $tsuruio::docker::params::lvm_mount_point_docker,
    docker_bind                  => $tsuruio::docker::params::bind_docker,
    docker_extra_opts            => $tsuruio::docker::params::extra_opts_docker
  }

  Class['::Base']->Class['::Docker']
}
