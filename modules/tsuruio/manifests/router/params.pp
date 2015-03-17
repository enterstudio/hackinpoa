class tsuruio::router::params {

  # Router
  $router_port                     = 8080
  $router_bind                     = '0.0.0.0'
  $router_workers                  = 5
  $router_max_sockets              = 100
  $router_dead_backend_ttl         = 30
  $router_tcp_timeout              = 300
  $router_http_keep_alive          = true
  $router_access_log               = '/var/log/hipache/access_log'
  $router_access_log_mode          = 'syslog'
  $router_redis_host               = '127.0.0.1'
  $router_redis_port               = 6379
  $router_redis_master_host        = 'redis.internal.tsuru.io'
  $router_redis_master_port        = 6379
  $router_service_hipache_enable   = true
  $router_service_hipache_ensure   = 'running'
  $router_service_hchecker_enable  = true
  $router_service_hchecker_ensure  = 'running'
  $router_hipache_package_version  = "0.2.5-6~${::lsbdistcodename}1"
  $router_hchecker_package_version = "0.2.4.3-0~${::lsbdistcodename}1"

  $hchecker_enabled            = 'yes'
  $hckecher_uri                = '/'
  $hchecker_redis_server       = 'redis.internal.tsuru.io:6379'
  $hchecker_redis_key_suffix   = $::hostname
  $hchecker_http_method        = 'HEAD'
  $hchecker_io_timeout         = 20
  $hchecker_check_interval     = 3
  $hchecker_connect_timeout    = 3
  $hchecker_redis_idle_timeout = 120
  $hchecker_redis_max_idle     = 3

}
