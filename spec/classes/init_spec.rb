require_relative '../spec_helper.rb'

describe 'jenkins' do
  context 'with default values for all parameters' do
    it { should contain_class 'jenkins' }
    it { is_expected.to compile.with_all_deps }
  end
end
