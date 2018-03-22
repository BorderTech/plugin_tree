require_relative '../spec_helper.rb'

describe 'jenkins::plugins' do
  it { is_expected.to compile }
  it { is_expected.to contain_plugins('installing_jenkins_plugins').with_plugin [ 'ssh' => '2.4'] }
end
