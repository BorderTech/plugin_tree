class plugin_tree::gem {
  package { 'rubyzip':
    ensure   => installed,
    provider => 'puppet_gem',
  }
}

