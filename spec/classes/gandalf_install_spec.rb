require 'spec_helper'

describe 'tsuruio::gandalf::install' do

  before (:each) do
     FileUtils.stubs(:mkdir_p).returns(true)
  end

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

    it { should contain_class('gandalf') }

    it { should contain_file('/etc/gandalf.conf').with_content(/host: git.hackinpoa.tsuru.io/) }

  end

end
