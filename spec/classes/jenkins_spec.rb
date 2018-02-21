require_relative '../spec_helper.rb'

describe 'plugin_tree::jenkins' do
  it { is_expected.to compile }
  it { is_expected.to contain_package('jenkins').with_ensure 'installed' }
  it { is_expected.to contain_user('jenkins').with_groups ['jenkins'] }
  it { is_expected.to contain_group('jenkins') }
end
