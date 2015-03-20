class tsuruio::common {

 cron { 'puppet apply' :
    command => '/var/lib/cloud/instance/scripts/part-001',
    minute  => fqdn_rand(60),
    hour    => '*'
  } 

  exec { 'set Sao_Paulo timezone' :
    command => 'echo "America/Sao_Paulo" | tee /etc/timezone && dpkg-reconfigure --frontend noninteractive tzdata',
    path    => [ '/bin', '/sbin', '/usr/bin', '/usr/sbin' ],
    unless  => 'cat /etc/timezone | grep Sao_Paulo'
  }

}
