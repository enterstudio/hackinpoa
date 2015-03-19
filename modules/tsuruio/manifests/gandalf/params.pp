class tsuruio::gandalf::params inherits tsuruio::common {

  $gandalf_host         = 'git.hackinpoa.tsuru.io'
  $gandalf_db_url       = "mongodb://mongo01.internal.tsuru.io:27017,mongo02.internal.tsuru.io:27017/tsuru"
  $gandalf_version      = "0.7.0-0~${::lsbdistcodename}1"
  $gandalf_storage_type   = 's3'
  $gandalf_storage_bucket = 'tsuru-archive'
  $tsuru_api_host       = 'api.internal.tsuru.io'
  $tsuru_api_token      = $::tsuru_api_token

}
