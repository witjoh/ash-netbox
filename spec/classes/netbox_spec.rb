require 'spec_helper'

describe 'netbox' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }
      let(:params) do
        {
          secret_key: sensitive('test secret key'),
          include_ldap: false,
          database_password: sensitive('very secure'),
        }
      end

      it { is_expected.to compile }
    end
  end
end
