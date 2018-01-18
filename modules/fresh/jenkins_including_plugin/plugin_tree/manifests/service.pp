class plugin_tree::service {
    service {"jenkins":
        enable  => true,
        ensure  => "running",
        hasrestart=> true,
        require => Package["jenkins"],
    }
}



