require_relative '../spec_helper.rb'

describe 'jenkins::java' do
  it { is_expected.to compile }
  it { is_expected.to contain_package('java') }
end
