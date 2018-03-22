require 'spec_helper'

describe service('jenkins') do
    it { is_expected.to be_running }
end
