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
