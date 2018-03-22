require 'spec_helper'

describe package('jenkins') do
  it { is_expected.to be_installed.with_version('2.7-1.1') }
end

describe command('netstat -an | grep 8080'), :if => os[:family] == 'redhat' do
  its(:exit_status) {should eq 0}
  its(:stdout) { is_expected.to match '8080' }
end

describe port(8080), :if => os[:family] == 'ubuntu' do
  it { should be_listening }
end

describe group('jenkins') do
  it { is_expected.to exist }
end

describe user('jenkins') do
  it { is_expected.to exist }
  it { is_expected.to belong_to_group('jenkins') }
end

describe file('/tmp') do
  it { is_expected.to exist }
  it { is_expected.to be_directory }
  it { is_expected.to be_owned_by('jenkins') }
end
