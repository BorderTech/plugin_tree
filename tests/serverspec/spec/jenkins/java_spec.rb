require 'spec_helper'

# describe package('java') do
#     it { is_expected.to be_installed }
# end

describe package('java-1.8.0-openjdk.x86_64') do
    it { is_expected.to be_installed }
end