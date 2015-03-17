class tsuruio::router::install inherits tsuruio::router::params {

  class { '::router::install':
    router_port                     => $tsuruio::router::params::router_port,
    router_bind                     => $tsuruio::router::params::router_bind,
    router_workers                  => $tsuruio::router::params::router_workers,
    router_max_sockets              => $tsuruio::router::params::router_max_sockets,
    router_dead_backend_ttl         => $tsuruio::router::params::router_dead_backend_ttl,
    router_tcp_timeout              => $tsuruio::router::params::router_tcp_timeout,
    router_http_keep_alive          => $tsuruio::router::params::router_http_keep_alive,
    router_access_log               => $tsuruio::router::params::router_access_log,
    router_access_log_mode          => $tsuruio::router::params::router_access_log_mode,
    router_redis_host               => $tsuruio::router::params::router_redis_host,
    router_redis_port               => $tsuruio::router::params::router_redis_port,
    router_redis_master_host        => $tsuruio::router::params::router_redis_master_host,
    router_redis_master_port        => $tsuruio::router::params::router_redis_master_port,
    router_service_hipache_enable   => $tsuruio::router::params::router_service_hipache_enable,
    router_service_hipache_ensure   => $tsuruio::router::params::router_service_hipache_ensure,
    router_service_hchecker_enable  => $tsuruio::router::params::router_service_hchecker_enable,
    router_service_hchecker_ensure  => $tsuruio::router::params::router_service_hchecker_ensure,
    router_hipache_package_version  => $tsuruio::router::params::router_hipache_package_version,
    router_hchecker_package_version => $tsuruio::router::params::router_hchecker_package_version,
    hchecker_enabled                => $tsuruio::router::params::hchecker_enabled,
    hckecher_uri                    => $tsuruio::router::params::hckecher_uri,
    hchecker_redis_server           => $tsuruio::router::params::hchecker_redis_server,
    hchecker_redis_key_suffix       => $tsuruio::router::params::hchecker_redis_key_suffix,
    hchecker_http_method            => $tsuruio::router::params::hchecker_http_method,
    hchecker_io_timeout             => $tsuruio::router::params::hchecker_io_timeout,
    hchecker_check_interval         => $tsuruio::router::params::hchecker_check_interval,
    hchecker_connect_timeout        => $tsuruio::router::params::hchecker_connect_timeout,
    hchecker_redis_idle_timeout     => $tsuruio::router::params::hchecker_redis_idle_timeout,
    hchecker_redis_max_idle         => $tsuruio::router::params::hchecker_redis_max_idle,
  }

  class { '::redis':
    conf_slaveof        => "${tsuruio::router::params::router_redis_master_host} ${tsuruio::router::params::router_redis_master_port}",
    package_ensure      => 'latest',
    service_ensure      => 'running',
    conf_slave_priority => 0
  }

  Class['::base']->Class['tsuruio::router::install']->Class['::router::install']
}
