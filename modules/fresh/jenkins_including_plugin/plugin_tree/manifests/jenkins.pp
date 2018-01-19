class plugin_tree::jenkins {
  package { 'jenkins':
    ensure   => "installed",
    provider => "rpm",
#    source   => "http://pkg.jenkins-ci.org/redhat/jenkins-1.460-1.1.noarch.rpm",
    source   => "/etc/puppetlabs/code/environments/production/modules/plugin_tree/files/jenkins-2.7-1.1.noarch.rpm",
  }
#    service {"jenkins":
#        enable  => true,
#        ensure  => "running",
#        hasrestart=> true,
#        require => Package["jenkins"],
#    }
} 

