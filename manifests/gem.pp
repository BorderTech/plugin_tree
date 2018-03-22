class jenkins::gem {
  package { 'rubyzip':
    provider => 'puppet_gem',
    ensure   => installed,
  }
}

