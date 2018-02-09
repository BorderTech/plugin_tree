class plugin_tree::jenkins {
  package { 'jenkins':
    ensure   => "installed",
    provider => "rpm",
    source   => "/etc/puppetlabs/code/environments/production/modules/plugin_tree/files/jenkins-2.7-1.1.noarch.rpm",
  }

  group { 'jenkins':
    ensure => 'present',
  }

  user { 'jenkins':
    ensure  => 'present',
    comment => 'Jenkins Continuous Integration Server',
    groups  => ['jenkins'],
    home    => '/var/lib/jenkins',
    shell   => '/bin/false'
  }

  file { '/tmp':
    ensure  => 'directory',
    source  => '/etc/puppetlabs/code/environments/production/modules/plugin_tree/files',
    recurse => 'remote',
    path    => '/tmp',
    owner   => 'jenkins',
    group   => 'jenkins',
    mode    => '0750',
    before  => Package['jenkins'],
  }
} 
