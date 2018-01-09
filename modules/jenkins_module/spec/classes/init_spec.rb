require 'spec_helper'
describe 'jenkins_module' do
  context 'with default values for all parameters' do
    it { should contain_class('jenkins_module') }
  end
end
