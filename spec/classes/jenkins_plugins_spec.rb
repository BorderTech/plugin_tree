require_relative '../spec_helper.rb'

describe 'plugin_tree::jenkins_plugins' do
  it { is_expected.to compile }
  it { is_expected.to contain_plugin_tree('install_jenkins_plugins').with_plugin ['cvs' => '2.13'] }
end
