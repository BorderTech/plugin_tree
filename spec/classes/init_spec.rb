require 'spec_helper'
describe 'plugin_tree' do
  context 'with default values for all parameters' do
    it { should contain_class('plugin_tree') }
  end
end
