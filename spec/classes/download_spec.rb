require 'spec_helper'

describe 'netbox::download' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }
      let(:params) do
        {
          install_root: '/opt',
          software_directory: '/opt/netbox',
          version: '1.0.0',
          download_url: 'https://example.com/netbox-1.0.0.tar.gz',
          download_tmp_dir: '/tmp',
          user: 'test',
          group: 'test',
          include_ldap: true,
        }
      end

      it { is_expected.to compile }
    end
  end
end
