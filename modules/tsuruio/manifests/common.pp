class tsuruio::common {

 cron { 'puppet apply' :
    command => '/var/lib/cloud/instance/scripts/part-001',
    minute  => fqdn_rand(60),
    hour    => '*'
  } 

}
