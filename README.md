What is it?
===========
This is the chef script I use to provision my home servers:

* galactica - a VM host which runs other servers via VirtualBox.
* More servers to come later...  Right now most of my servers are VirtualBox servers from before
  I started using chef, so I've just manually installed them all on galactica.

If you're not me, and you want to use this to provision your own servers, you should modify
nodes/default.json, and at a minimum change the `set_fqdn` key to whatever you want to use.

Testing with Vagrant
====================

* Install virtualbox and vagrant
* `vagrant plugin install vagrant-omnibus`
* `vagrant plugin install vagrant-berkshelf`
* `vagrant up` to create a VM using attributes from default.json

If you want to test galactica, you should edit the Vagrantfile and change "default.json" to "galactica.json".
Similar for other servers.

Prerequisites when creating a new server
========================================

### Server

If you're installing the VM server, then you need a computer with Ubuntu Server 12.04.1 installed
(or similar).  Run `sudo apt-get update` on the server before you do anything else.  Create an
ssh keypair if you don't already have one:

    ssh-keygen -t rsa -C "your_email@example.com"

And then copy your key to the host, either with:

    ssh-copy-id user@host

or:

    scp ~/.ssh/id_rsa.pub user@host:~/.ssh/authorized_keys

Finally, SSH to the target machine, run `sudo apt-get update`, `sudo apt-get upgrade -u`, and
finally add the line:

    Defaults    exempt_group=sudo

to /etc/sudoers, so chef can run without being asked for a password.

### Data Bags

On the local machine, run:

    scp -r ./data_bags user@host.com:~/data_bags

Where "user@host.com" should be replaced with the address of the new server.  SSH to the new server,
edit the contents of the data-bags as required, then run:

    sudo mv ./data_bags /var/chef
    sudo chmod 700 /var/chef/data-bags

Deploying to a server
=====================

Installing to galactica, assuming you created a user called "ubuntu" when installing Ubuntu:

    ssh-copy-id ubuntu@[galactica-ip-goes-here]
    ./install.sh ubuntu@[galactica-ip-goes-here] nodes/galactica.json

Note that you do *not* want to run `chef-install.sh` on your development machine - it's the script that gets run on the target to run chef there.  Running it on your local machine will run your cookbook on your local machine, which is usually undesirable.

After installing, modify /etc/virtualbox/machines_enabled and add UIDs of machines you want to start at startup.
