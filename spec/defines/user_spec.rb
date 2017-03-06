require 'spec_helper'

describe 'foreman_simple_user::user' do
  let (:title) { 'admin' }

  describe 'without keys' do
    let :params do
      {}
    end

    it { is_expected.to compile.with_all_deps }

    it 'should create the user' do
      is_expected.to contain_user('admin')
        .with_home('/home/admin')
        .with_password(nil)
        .with_purge_ssh_keys(true)
    end

    it 'should create the group' do
      is_expected.to contain_group('admin')
    end

    it 'should not ensure the .ssh directory' do
      is_expected.not_to contain_file('/home/admin/.ssh')
    end
  end

  describe 'with keys' do
    let :params do
      {
        'ssh_authorized_keys' => [
          {
            'key'     => 'AAA..BBB',
            'type'    => 'ssh-rsa',
            'comment' => 'user@example.com',
          },
          {
            'key'     => 'CCC..DDD',
            'type'    => 'ssh-dss',
            'comment' => 'user@example.com',
          },
        ],
      }
    end

    it { is_expected.to compile.with_all_deps }

    it 'should create the user' do
      is_expected.to contain_user('admin')
        .with_home('/home/admin')
        .with_password(nil)
        .with_purge_ssh_keys(true)
    end

    it 'should create the group' do
      is_expected.to contain_group('admin')
    end

    it 'should ensure the .ssh directory' do
      is_expected.to contain_file('/home/admin/.ssh')
        .with_owner('admin')
        .with_group('admin')
        .with_mode('0700')
    end

    it 'should configure the SSH key' do
      is_expected.to contain_ssh_authorized_key('user@example.com')
        .with_user('admin')
        .with_key('AAA..BBB')
        .with_type('ssh-rsa')
    end

    it 'should configure the SSH key' do
      is_expected.to contain_ssh_authorized_key('user@example.com - 1')
        .with_user('admin')
        .with_key('CCC..DDD')
        .with_type('ssh-dss')
    end
  end
end
