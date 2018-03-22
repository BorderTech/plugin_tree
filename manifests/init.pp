class jenkins () {
  class { '::jenkins::java': } ->
  class { '::jenkins::jenkins': } ->
  class { '::jenkins::plugins': } ->
  class { '::jenkins::service': }
}
