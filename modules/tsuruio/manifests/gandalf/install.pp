class tsuruio::gandalf::install inherits tsuruio::gandalf::params {

  class { '::gandalf':
    gandalf_host            => $tsuruio::gandalf::params::gandalf_host,
    gandalf_db_url          => $tsuruio::gandalf::params::gandalf_db_url,
    gandalf_version         => $tsuruio::gandalf::params::gandalf_version,
    gandalf_storage_type    => $tsuruio::gandalf::params::gandalf_storage_type,
    gandalf_storage_bucket  => $tsuruio::gandalf::params::gandalf_storage_bucket,
    tsuru_api_host          => $tsuruio::gandalf::params::tsuru_api_host,
    tsuru_api_token         => $tsuruio::gandalf::params::tsuru_api_token
  }

}
