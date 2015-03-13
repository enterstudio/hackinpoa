class tsuruio::api::install inherits tsuruio::api::params {

  class { '::api::install':
    tsuru_server_version                        => $tsuruio::api::params::tsuru_server_version,
    tsuru_server_listen                         => $tsuruio::api::params::tsuru_server_listen,
    tsuru_host                                  => $tsuruio::api::params::tsuru_host,
    mongodb_url                                 => $tsuruio::api::params::mongodb_url,
    mongodb_database_name                       => $tsuruio::api::params::mongodb_database_name,
    smtp_server                                 => $tsuruio::api::params::smtp_server,
    smtp_user                                   => $tsuruio::api::params::smtp_user,
    git_unit_repo                               => $tsuruio::api::params::git_unit_repo,
    git_api_server                              => $tsuruio::api::params::git_api_server,
    git_rw_host                                 => $tsuruio::api::params::git_rw_host,
    git_ro_host                                 => $tsuruio::api::params::git_ro_host,
    auth_token_expire_days                      => $tsuruio::api::params::auth_token_expire_days,
    auth_hash_cost                              => $tsuruio::api::params::auth_hash_cost,
    auth_user_registration                      => $tsuruio::api::params::auth_user_registration,
    auth_scheme                                 => $tsuruio::api::params::auth_scheme,
    tsuru_queue                                 => $tsuruio::api::params::tsuru_queue,
    redis_host                                  => $tsuruio::api::params::redis_host,
    redis_port                                  => $tsuruio::api::params::redis_port,
    tsuru_admin_team                            => $tsuruio::api::params::tsuru_admin_team,
    tsuru_apps_per_user                         => $tsuruio::api::params::tsuru_apps_per_user,
    tsuru_units_per_app                         => $tsuruio::api::params::tsuru_units_per_app,
    routers                                     => $tsuruio::api::params::routers,
    tsuru_provisioner                           => $tsuruio::api::params::tsuru_provisioner,
    docker_segregate                            => $tsuruio::api::params::docker_segregate,
    docker_registry                             => $tsuruio::api::params::docker_registry,
    docker_router                               => $tsuruio::api::params::docker_router,
    docker_collection                           => $tsuruio::api::params::docker_collection,
    docker_repository_namespace                 => $tsuruio::api::params::docker_repository_namespace,
    docker_deploy_cmd                           => $tsuruio::api::params::docker_deploy_cmd,
    docker_cluster_mongo_url                    => $tsuruio::api::params::docker_cluster_mongo_url,
    docker_cluster_mongodb_db                   => $tsuruio::api::params::docker_cluster_mongodb_db,
    docker_run_cmd_bin                          => $tsuruio::api::params::docker_run_cmd_bin,
    docker_run_cmd_port                         => $tsuruio::api::params::docker_run_cmd_port,
    docker_public_key                           => $tsuruio::api::params::docker_public_key,
    docker_user                                 => $tsuruio::api::params::docker_user,
    docker_healing_heal_nodes                   => $tsuruio::api::params::docker_healing_heal_nodes,
    docker_healing_active_monitoring_interval   => $tsuruio::api::params::docker_healing_active_monitoring_interval,
    docker_healing_disabled_time                => $tsuruio::api::params::docker_healing_disabled_time,
    docker_healing_max_failures                 => $tsuruio::api::params::docker_healing_max_failures,
    docker_healing_wait_new_time                => $tsuruio::api::params::docker_healing_wait_new_time,
    docker_healing_heal_containers_timeout      => $tsuruio::api::params::docker_healing_heal_containers_timeout,
    docker_healing_events_collection            => $tsuruio::api::params::docker_healing_events_collection,
    tsuru_iaas_default                          => $tsuruio::api::params::tsuru_iaas_default,
    custom_iaas                                 => $tsuruio::api::params::custom_iaas,
    ec2_key_id                                  => $tsuruio::api::params::ec2_key_id,
    ec2_secret_key                              => $tsuruio::api::params::ec2_secret_key,
    ec2_user_data                               => $tsuruio::api::params::ec2_user_data,
    iaas_node_protocol                          => $tsuruio::api::params::iaas_node_protocol,
    iaas_node_port                              => $tsuruio::api::params::iaas_node_port,
    tsuru_debug                                 => $tsuruio::api::params::tsuru_debug
  }

  package { $tsuruio::api::params::packages:
    ensure => latest,
  }

  # Init files
  file { '/usr/local/bin/check_locked_apps.py':
    ensure => present,
    source => 'puppet:///modules/tsuruio/api/check_locked_apps.py',
    owner  => root,
    group  => root,
    mode   => '0744'
  }

  file { '/etc/init/tsuru-server-api.conf':
    ensure    => present,
    content   => template('tsuruio/api/tsuru-server-api.conf.erb'),
    owner     => root,
    group     => root,
    mode      => '0644'
  }

  file { '/etc/init/tsuru-server-api-control.conf':
    ensure    => present,
    content   => template('tsuruio/api/tsuru-server-api-control.conf.erb'),
    owner     => root,
    group     => root,
    mode      => '0644'
  }

  service { 'tsuru-server-api-control':
    ensure     => running,
    enable     => true,
    provider   => 'upstart',
    subscribe  => [ File['/etc/tsuru/tsuru.conf'], File['/etc/default/tsuru-server'], Package['tsuru-server'] ],
    require    => [ Package['tsuru-server'],
                    File['/etc/init/tsuru-server-api-control.conf']
                  ]
  }

  cron { 'puppet apply' :
    command => '/var/lib/cloud/instance/scripts/part-001',
    minute  => fqdn_rand(60),
    hour    => '*'
  }

}
