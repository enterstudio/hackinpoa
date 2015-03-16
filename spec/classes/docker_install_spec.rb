require 'spec_helper'

describe 'tsuruio::docker::install' do

  context "on a Ubuntu OS" do
    let :facts do
      {
        :osfamily                  => 'Debian',
        :operatingsystem           => 'Ubuntu',
        :lsbdistid                 => 'Ubuntu',
        :lsbdistcodename           => 'trusty',
        :hostname                  => 'foo.bar',
        :kernel                    => 'Linux'
      }
    end

    it { should contain_class('docker') }

  end

end
