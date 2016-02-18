node default {

    # Both NGINX and Git need to know where HTML goes.
    $docroot = "/var/www/default"

    class { "nginx_httpd":
        port => 8888,
        docroot => $docroot,
    }
}
