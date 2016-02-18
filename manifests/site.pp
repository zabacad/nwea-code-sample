node default {

    # Both NGINX and Git need to know where HTML goes.
    $docroot = "/var/www/default"

    class { "nginx_httpd":
        port => 8888,
        docroot => $docroot,
    }

    class { "git_deploy":
        url => "git@github.com:nwea-techops/tech_quiz.git",
        deploy_to => $docroot,
    }
}
