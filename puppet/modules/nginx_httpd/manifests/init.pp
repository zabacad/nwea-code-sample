class nginx_httpd (
    $port = 80,
    $docroot = "/var/www/html",
) {

    package { "nginx":
        ensure => installed,
    }

    service { "nginx":
        require => Package["nginx"],
        ensure => running,
    }

    # Create config for default vhost.
    file { "/etc/nginx/sites-available/default":
        # Install package before this file or /etc/nginx/ won't exist.
        require => Package['nginx'],
        ensure => file,
        content => template("nginx_httpd/default.erb"),
    }

    # Enable default vhost.
    file { "/etc/nginx/sites-enabled/default":
        notify => Service["nginx"],
        require => File["/etc/nginx/sites-available/default"],
        ensure => link,
        target => "../sites-available/default",
    }

    # Docroot files
    file { $docroot:
        # Disabled: Puppet cannot create parent directories.
        # ensure => directory,
    }
}
