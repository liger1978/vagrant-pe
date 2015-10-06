# vagrant-pe
A multi-machine Vagrant development environment for Puppet Enterprise 2015 with
R10K and GitLab.

## Usage
First install [VirtualBox](https://www.virtualbox.org/) and
[Vagrant](https://www.vagrantup.com/downloads.html) and then run the following
commands:

````bash
# Install required oscar plugin:
vagrant plugin install oscar

# Install recommended plugins:
vagrant plugin install vagrant-cachier vagrant-hostmanager
 
# Clone repo:
git clone https://github.com/liger1978/vagrant-pe.git

# Start and provision the Vagrant environment:
cd vagrant-pe
vagrant up

# Deploy environments from GitLab repo to Puppet server:
vagrant ssh master
sudo r10k deploy environment -p -v
exit

# Test agent:
vagrant ssh first
sudo puppet agent --test
cat /etc/motd
exit
````

## Machines

All machines (VM guests) are currently CentOS 7 and use the generic base boxes
created by PuppetLabs.

### gitlab

The `gitlab` machine is a [GitLab](https://about.gitlab.com) server that holds
the ``puppet/control`` repo that is used by [R10K to populate the Puppet
environments](https://docs.puppetlabs.com/pe/latest/quick_start_r10k.html) on
the `master` Puppet Enterprise server. It also has a ``puppet/helloworld`` repo
that contains an example module referenced in the ``site.pp`` manifest.

If you have the ``vagrant-hostmanager`` plugin installed, you can access the
GitLab web interface from your host's web browser at
[http://gitlab](http://gitlab), using the following default login credentials:

| **Username** | **Password** |
|--------------|--------------|
| `root`       | `5iveL!fe`   |

This machine also has the puppet agent installed.

### master

The `master` machine is a Puppet Enterprise server. It has been configured to
pull down Puppet code from the repos on the `gitlab` machine using [R10K]
(https://docs.puppetlabs.com/pe/latest/r10k.html).

If you have the ``vagrant-hostmanager`` plugin installed, you can access the
PE console from your host's web browser at [https://master](https://master),
using the following default login credentials:

| **Username** | **Password** |
|--------------|--------------|
| `Admin`      | `puppetlabs` |

### first
The `first` machine is a basic CentOS machine with the PE agent installed.

## A note on security

This Vagrant environment is suitable for testing and development on your own
computer.  The virtual machines are accessible from the host, but not from your
network (by default). The Puppet server and GitLab have been configured with
default administrator passwords.  The Puppet server has been configured with a
default SSH private key that is accessible in this repository. Please change all
security tokens and conduct security hardening if you plan to use this
environment for anything other than testing and development on your own machine.

## Known issues

[Windows permission denied issue](https://github.com/liger1978/vagrant-pe/issues/4)

When using the above on Microsoft Windows, you may get and get an error when you run `vagrant up`, e.g.:

```
==> first: Running provisioner: pe_bootstrap...
Fetching: https://s3.amazonaws.com/pe-builds/released/2015.2.0/puppet-enterprise-2015.2.0-el-7-x86_64.tar.gz
An error occurred while trying to download the given resource (https://s3.amazonaws.com/pe-builds/released/2015.2.0/puppet-enterprise-2015.2.0-el-7-x86_64.tar.gz),
and the transfer could not complete.
The error message generated was
"Permission denied - (C:/Users/harbottle/AppData/Local/Temp/open-uri20150909-8432-11s1yru, C:/Users/harbottle/.vagrant.d/pe_builds/puppet-enterprise-2015.2.0-el-7-x86_64.tar.gz)".
```
This is caused by an open issue with
[oscar-stack/vagrant-pe_build](https://github.com/oscar-stack/vagrant-pe_build).
The [issue log](https://github.com/oscar-stack/vagrant-pe_build/issues/60)
describes the cause of the issue and the workaround. 

The workaround is to manually copy the PE installer, e.g.:
https://s3.amazonaws.com/pe-builds/released/2015.2.0/puppet-enterprise-2015.2.0-el-7-x86_64.tar.gz
to `VAGRANT_HOME/pe_builds`.