class tsuruio::registry::install inherits tsuruio::registry::params {

  include tsuruio::docker::install

  exec { 'install registry':
    command => '/usr/bin/docker pull registry',
    path    => '/usr/bin',
    require => Class['::Docker']
  }

  exec { 'start registry':
    command => "/usr/bin/docker run -e SETTINGS_FLAVOR=s3 -e AWS_BUCKET=${tsuruio::registry::params::bucket}
                -e STORAGE_PATH=/registry \
                -e AWS_KEY=${tsuruio::registry::params::aws_key} \
                -e AWS_SECRET=${tsuruio::registry::params::aws_secret} \
                -e SEARCH_BACKEND=sqlalchemy \
                -p ${tsuruio::registry::params::port}:5000 registry",
    path    =>  '/usr/bin',
    unless  =>  '/usr/bin/docker inspect --format="{{ .State.Running }}" $(docker ps -q)',
    require => Exec['install registry']
  }

}
