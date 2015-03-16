class tsuruio::docker::params {

  $lxc_docker_version = '1.4.1'
  $docker_port = 4243
  $bind_docker = ["tcp://0.0.0.0:${docker_port}", 'unix:///var/run/docker.sock']
  $extra_opts_docker   = "-r --insecure-registry registry.internal.tsuru.io"

}
