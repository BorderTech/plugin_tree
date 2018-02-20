class plugin_tree::service {
  service { 'jenkins':
    ensure     => 'running',
    enable     => true,
    hasrestart => true,
    require    => Package['jenkins'],
  }
}



