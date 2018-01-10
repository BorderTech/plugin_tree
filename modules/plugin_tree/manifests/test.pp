plugin_tree { 'test':
  name   => 'installing_jenkins_plugin',
  plugin => {
        'ant'         => '1.7',
        'credentials' => '2.1.16'
  },
  path   => '/home/user/tmp',
}
