#!/bin/bash -e

function meta_info () {
    local meta_info=$1
    curl "http://169.254.169.254/latest/meta-data/${meta_info}" 2>/dev/null
}

function call_aws_elb () {
    local elb_name=$1
    local instance=$2
    AWS_DEFAULT_REGION=sa-east-1 LC_ALL=en_US.UTF-8 aws elb register-instances-with-load-balancer --load-balancer-name "${elb_name}" \
                                                    --instances "${instance}"
}

function get_aws_credentials () {
    local security_group=$1
    aws_json_credentials=$(meta_info iam/security-credentials/"${security_group}")
    aws_keys=($(echo "${aws_json_credentials}" | jq '.AccessKeyId , .SecretAccessKey'))
    export FACTER_AWS_ACCESS_KEY=${aws_keys[0]}
    export FACTER_AWS_SECRET_KEY=${aws_keys[1]}
}

function puppet_module_group() {
    case $1 in
        docker-nodes)
            "tsuru/docker puppetlabs/firewall"
        ;;
        registry)
            "tsuru/docker puppetlabs/firewall"
        ;;
        router)
            "tsuru/router"
        ;;
        tsuru-api)
            "tsuru/api"
        ;;
        gandalf)
    esac
}

function auto_insert_on_elb() {
    instance_id=$(meta_info instance-id)
    case $1 in
        registry)
            call_aws_elb docker-registry "${instance_id}"
        ;;
        tsuru-api)
            call_aws_elb tsuru-api-private "${instance_id}"
            call_aws_elb tsuru-api-public "${instance_id}"
        ;;
        router)
            call_aws_elb router "${instance_id}"
        ;;
    esac
}

function install_requirements () {
    apt-get install -y awscli puppet-common jq
}

function main() {
    machine_group=$(meta_info security-groups)
    export AWS_DEFAULT_REGION="sa-east-1"
    export LC_ALL="en_US.UTF-8"

    apt-get update && install_requirements

    for module in $(puppet_module_group "${machine_group}")
    do
        puppet module install "${module}" || puppet module upgrade "${module}"
    done

    if [ -d /var/cache/puppet-data ]; then
        rm -rf /var/cache/puppet-data
    fi
    mkdir /var/cache/puppet-data

    get_aws_credentials "${machine_group}"
    aws s3 sync s3://tsuru-confs/ /var/cache/puppet-data
    cd /var/cache/puppet-data/manifests && puppet apply --modulepath '/etc/puppet/modules:/var/cache/puppet-data/modules' "${machine_group}".pp -l /var/log/puppet.log
    auto_insert_on_elb "${machine_group}"
}

main
