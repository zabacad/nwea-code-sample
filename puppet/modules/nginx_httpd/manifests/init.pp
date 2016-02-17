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

    # Configuration files
    file { "/etc/nginx/sites-available/default":
        # Install package before this file.
        require => Package['nginx'],
        ensure => file,
        content => template("nginx_httpd/default.erb"),
    }

    # Docroot files
    file { $docroot:
        # Install package before this file.
        require => Package['nginx'],
        # Puppet cannot create parent directories.
        #ensure => directory,
    }
}
