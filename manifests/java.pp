class jenkins::java {
  package { 'java':
    ensure => present,
  }
}
