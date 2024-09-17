require 'spec_helper'

describe 'netbox::service' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }
      let(:params) do
        {
          software_directory: '/opt/netbox',
          restart_service: true,
          user: 'testuser',
          group: 'testpass',
        }
      end

      it { is_expected.to compile }
    end
  end
end
