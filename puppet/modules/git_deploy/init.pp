class git_deploy (
    $url,
    $deploy_to,
    # Repo path to deploy, such as "master", "prod", "tags/v1.0", etc.
    $target = "master",
) {

    Exec { path => ["/usr/bin", "/usr/local/bin", "/bin"] }

    package { "git":
        ensure => installed,
    }

    file { "checkout":
        path => "$deploy_to/.git",
        ensure => directory,
        require => Exec["clone"],
    }

    exec { "clone":
        # Git creates the directory and parents, so Puppet doesn't need to.
        command => "git clone $url $deploy_to",
        cwd => "/",
        # Only clone once. 
        creates => "$deploy_to/.git",
    }

    # Update the repo every Puppet run.
    exec { "updade":
        command => "git fetch --all && git checkout --force $target",
        cwd => "$deploy_to",
        # Ensure the repo was cloned.
        require => File["checkout"],
    }
}
