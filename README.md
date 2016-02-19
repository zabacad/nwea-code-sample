# NWEA code sample

> Complete the following goals with your configuration management tool of
> choice (i.e. Puppet, Chef, Ansible, Salt, etc.).
>
> Objective goals:
>
> Automate the configuration and installation of Nginx on a Linux system,
> ideally RedHat, CentOS, or Fedora.
>
> Nginx should listen on port 8888.
>
> The content served should be from the following repository:
> https://github.com/nwea-techops/tech_quiz

## About

This solution uses masterless Puppet and the default node definition. Only try
it on a (virtual) machine you don't care about.

This was tested on an LXC container running Ubuntu 14.04 LTS ("Trusty").

## Usage

1. Install Puppet and Git.

        # apt-get update
        # apt-get install -y puppet git

2. Remove the default Puppet configuration.

        # rm -r /etc/puppet

3. Clone this repo into `/etc/puppet`.

        # git clone git@github.com:zabacad/nwea-code-sample.git /etc/puppet

4. Run `puppet apply` using the included manifest.

        # puppet apply --test /etc/puppet/manifests/site.pp

5. Check that NGINX is serving the desired content.

        $ wget localhost:8888

## Questions

### Why did I choose this solution?

I chose Puppet because I have read a number of custom Puppet modules and seen
how they work. (Also, Puppet Labs is local.) I also considered Ansible because
I have seen it in action a little.

I created my own modules rather than use community ones to demonstrate ability
and coding style. They also also much smaller and to the point.

I chose Ubuntu because I have a working NGINX configuration that I could refer
back to. This is also the OS I have seen Puppet run on and the one I have most
experience with, so I knew the distribution-specific paths and package quirks.

### What is the best part of this soluction?

After initially cloning the content repo, Puppet will update it on future runs,
including switching branches or tags, without re-cloning. Also, the NGINX and
Git modules can each be used on their own.

### What is the worst part of this solution?

This is no formal nor automated testing. There are number of known and unknown
failure modes for this solution, but there is no proper way of knowing them
without proper testing.

Additionally, file and process ownership is not taken into account, which is a
security risk.

### Why would automating a task like this be helpful?

An automation task like this ensures configurations are consistent and content
is up to date. Consistency helps with security and reliability. Automation like
this also allows for quick deployment of servers, helping with horizonal
scalability.
