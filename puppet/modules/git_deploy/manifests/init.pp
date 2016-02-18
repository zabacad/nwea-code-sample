#
# Maintains a local checkout of a Git repository.
#
#  url       - Git clone URL.
#  deploy_to - Where to check out the repo.
#  target    - Repo path, such as branch or tag, to deploy. Examples: "master", "prod", "tags/v1.0". Default: "master".
#

class git_deploy (
    $url,
    $deploy_to,
    $target = "master",
) {

    # Path to Git only.
    Exec { path => ["/usr/bin", "/usr/local/bin", "/bin"] }

    package { "git":
        ensure => installed,
    }

    # If .git doesn't exist, clone the repo.
    file { "checkout":
        path => "$deploy_to/.git",
        ensure => directory,
        require => Exec["clone"],
    }

    # Clone the repo.
    exec { "clone":
        # Git creates the directory and parents, so Puppet doesn't need to.
        command => "git clone $url $deploy_to",
        # CWD is not used.
        cwd => "/tmp",
        # If .git exists, don't clone again.
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
