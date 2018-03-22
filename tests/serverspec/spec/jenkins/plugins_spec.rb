require_relative '../spec_helper'
require 'json'

def expected_plugins
  json = File.read('spec/jenkins/expected_plugins.json')
  (JSON.parse json)['expected_plugins']
end

context 'Validate all root-level plugins are installed' do
  expected_plugins.each do |plugin_name, plugin_version|
    describe file "/var/lib/jenkins/plugins/#{plugin_name}.hpi" do
      it { is_expected.to exist }
    end
    # for test to work you need to sudo chmod 775 /var/lib/jenkins/plugins
    describe command("cd /var/lib/jenkins/plugins; unzip -p #{plugin_name}.hpi META-INF/MANIFEST.MF | grep Plugin-Version | awk -F \' \' \'{print $2}\'") do
      its(:stdout) { is_expected.to match(plugin_version) }
    end
  end
end
