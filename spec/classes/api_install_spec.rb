require 'spec_helper'

describe 'tsuruio::api::install' do

  context "on a Ubuntu OS" do
    let :facts do
      {
        :osfamily                  => 'Debian',
        :operatingsystem           => 'Ubuntu',
        :lsbdistid                 => 'Ubuntu',
        :lsbdistcodename           => 'trusty',
        :hostname                  => 'foo.bar',
      }
    end

    it { should contain_class('api') }

    it { should contain_file('/etc/tsuru/tsuru.conf').with_content(/host: "http:\/\/api.internal.tsuru.io"/) }

  end

end
