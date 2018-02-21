require_relative '../spec_helper.rb'

describe 'plugin_tree' do
  context 'with default values for all parameters' do
    it { should contain_class 'plugin_tree' }
    it { is_expected.to compile.with_all_deps }
  end
end
