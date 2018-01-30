

class plugin_tree::jenkins_plugins {

plugin_tree { 'test':
  name        => 'installing_jenkins_plugin',
  #ensure      => absent,
  plugin      => {

#'blueocean' => '1.4.0',
#'ant'        => '1.4',
'cvs'        =>  '2.13',

  },
  source      => 'mirrors.shuosc.org',
  source_path => '/jenkins/plugins',
  dest_path   => '/var/lib/jenkins/plugins',
  owner       => 'jenkins', 
  group       => 'jenkins', 
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
