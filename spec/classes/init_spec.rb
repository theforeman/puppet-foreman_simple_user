require 'spec_helper'

describe 'foreman_simple_user' do
  describe 'without users' do
    let :params do
      {:users => {}}
    end

    it { is_expected.to compile.with_all_deps }
  end

  describe 'with a user' do
    let :params do
      {
        'users' => {
          'admin' => {
            'authorized_keys' => [
              {
                'key'     => 'AAA..BBB',
                'comment' => 'My First Key',
              },
            ],
          },
        },
      }
    end

    it { is_expected.to compile.with_all_deps }

    it 'should create the admin user' do
      is_expected.to contain_foreman_simple_user__user('admin')
        .with_username('admin')
        .with_home('/home/admin')
        .with_password(nil)
        .with_authorized_keys([{'comment' => 'My First Key', 'key' => 'AAA..BBB'}])
    end
  end
end
