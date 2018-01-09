require 'spec_helper'
describe 'testing' do
  context 'with default values for all parameters' do
    it { should contain_class('testing') }
  end
end
