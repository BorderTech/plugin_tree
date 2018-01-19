

class plugin_tree::jenkins_plugins {

plugin_tree { 'test':
  name        => 'installing_jenkins_plugin',
  plugin      => {
               'ant'         => '1.7',
               'credentials' => '2.1.16'
  },
  source      => 'mirrors.shuosc.org',
  source_path => '/jenkins/plugins',
  dest_path   => '/var/lib/jenkins/plugins',
  require     => File['/var/lib/jenkins/plugins'] 
}
file {'/var/lib/jenkins/plugins':
  ensure => 'directory',
  owner  => 'jenkins',
  group  => 'jenkins',
  mode   => '0750',
  before => Plugin_tree['test'],
}
}
