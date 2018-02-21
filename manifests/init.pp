class plugin_tree () {
  class { '::plugin_tree::java': }
  -> class { '::plugin_tree::jenkins': }
  -> class { '::plugin_tree::jenkins_plugins': }
  -> class { '::plugin_tree::service': }
}
