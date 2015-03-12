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

  end

end
