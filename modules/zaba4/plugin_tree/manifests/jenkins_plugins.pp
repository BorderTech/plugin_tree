
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
}
}
