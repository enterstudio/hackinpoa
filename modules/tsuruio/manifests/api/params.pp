class tsuruio::api::params {

  $tsuru_server_version = "0.10.2-0~${::lsbdistcodename}1"

  $tsuru_server_listen = '0.0.0.0:8080'
  $tsuru_host          = 'http://api.internal.tsuru.io'

  $mongodb_url = "mongodb://mongo01.internal.tsuru.io:27017,mongo02.internal.tsuru.io:27017/tsuru"
  $mongodb_database_name = 'tsuru'

  $smtp_server = 'localhost'
  $smtp_user = 'tsuru@corp.globo.com'

  $git_unit_repo = '/home/application/current'
  $git_api_server = 'http://git.hackinpoa.tsuru.io'
  $git_rw_host = 'git.hackinpoa.tsuru.io'
  $git_ro_host = 'git.hackinpoa.tsuru.io'

  $auth_token_expire_days = 7
  $auth_hash_cost = 10
  $auth_user_registration = true
  $auth_scheme = 'native'

  $tsuru_queue = 'redis'
  $redis_host = 'redis.internal.tsuru.io'
  $redis_port = 6379

  $tsuru_admin_team = 'tsuruteam'

  $tsuru_apps_per_user = 4
  $tsuru_units_per_app = 40

  $routers =  { 'hipache_prod' => { 'router_type'    => 'hipache',
                                    'hipache_domain' => 'hackinpoa.tsuru.io',
                                    'hipache_redis_server' => 'redis.internal.tsuru.io:6379' }
              }

  $tsuru_provisioner = 'docker'
  $docker_segregate = true
  $docker_registry = 'registry.internal.tsuru.io'
  $docker_router = 'hipache_prod'
  $docker_collection = 'docker'
  $docker_repository_namespace = 'tsuru'
  $docker_deploy_cmd = '/var/lib/tsuru/deploy'
  $docker_cluster_mongo_url = 'mongodb://mongo01.internal.tsuru.io:27017,mongo02.internal.tsuru.io:27017/tsuru_cluster'
  $docker_cluster_mongodb_db = 'tsuru_cluster'
  $docker_run_cmd_bin = '/var/lib/tsuru/start'
  $docker_run_cmd_port = '8888'
  $docker_ssh_add_key_cmd = '/var/lib/tsuru/add-key'
  $docker_user = 'ubuntu'
  $docker_sshd_path = 'sudo /usr/sbin/sshd'

  # containers healing
  $docker_healing_heal_nodes = true
  $docker_healing_active_monitoring_interval = 0
  $docker_healing_disabled_time = 30
  $docker_healing_max_failures = 5
  $docker_healing_wait_new_time = 600
  $docker_healing_heal_containers_timeout = 300
  $docker_healing_events_collection = 'healing_events'
  $docker_healthcheck_max_time = 120

  # Ec2 credentials
  $ec2_key_id = $::aws_access_key
  $ec2_secret_key = $::aws_secret_key
  $ec2_user_data = "https://s3-sa-east-1.amazonaws.com/tsuru-confs/aws_userdata.sh"

  $iaas_node_protocol = 'http'
  $iaas_node_port = 4243

  $tsuru_debug = false

  # versions
  $tsuru_api_version = "0.7.2-0~${::lsbdistcodename}1"

  # Packages
  $packages = [ 'python-pymongo', 'python-yaml' ]

  # Key file share
  $key_path = '/var/lib/tsuru'
  $private_key = "${key_path}/id_rsa"

  # Redis
  $redis = 'redis.internal.tsuru.io'

  # Docker
  $bind_docker = '0.0.0.0:4243'
  $extra_opts_docker = '-r'  

}
