require_relative '../spec_helper.rb'

describe 'plugin_tree::java' do
  it { is_expected.to compile }
  it { is_expected.to contain_package('java') }
end
