#package { 'rubyzip':
#  ensure   => present,
#  provider => pe_gem,
#}
class plugin_tree::gem {
  package { 'rubyzip' :
    provider => 'puppet_gem',
    ensure   => installed,
   #before    => Class['jenkins_plugins']
  }
}

