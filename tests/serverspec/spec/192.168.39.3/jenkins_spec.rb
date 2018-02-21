require_relative '../spec_helper'

describe 'jenkins-master' do
  describe user 'jenkins' do
    it { should exist }
  end

  describe service 'jenkins' do
    it { is_expected.to be_enabled }
  end

  describe port 8080 do
    it { should be_listening }
  end
end
