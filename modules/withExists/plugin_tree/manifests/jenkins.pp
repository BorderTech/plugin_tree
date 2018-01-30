class plugin_tree::jenkins {
  package { 'jenkins':
    ensure   => "installed",
    provider => "rpm",
    #source   => "http://pkg.jenkins-ci.org/redhat/jenkins-1.460-1.1.noarch.rpm",
    #source   => "/etc/puppetlabs/code/environments/production/modules/plugin_tree/files/jenkins-2.7-1.1.noarch.rpm",
    source =>  "/etc/puppetlabs/code/environments/production/modules/plugin_tree/jenkins-2.7-1.1.noarch.rpm",
  }
file { '/tmp':
    ensure =>  'directory',
    #source =>  'puppet:///modules/ycsb/scripts',
    #source =>  'puppet:///modules/plugin_tree/files',
    source =>  '/etc/puppetlabs/code/environments/production/modules/plugin_tree/files',
    recurse =>  'remote',
    path =>  '/tmp',
    owner =>  'jenkins',
    group =>  'jenkins',
    mode =>  '0750',
    before =>  Package['jenkins'],
  } 
} 

