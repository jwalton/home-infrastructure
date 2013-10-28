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

Finally, SSH to the target machine and run `sudo apt-get update`.

### Data Bags

Run:

    sudo mkdir -p /var/chef/home-infrastructure/data_bags
    sudo cp -r databags/* /var/chef/home-infrastructure/data_bags

Then edit the data in /var/chef/home-infrastructure/data_bags as appropriate.  The data bags from
/var/chef/home-infrastructure/data_bags will only be used in a full install; for vagrant, the
data bags in the project will be used, instead.


Deploying to a server
=====================

Install to a server with:

    ssh-copy-id user@host.com
    ./install.sh user@host.com [node.json]

Note that you do *not* want to run `chef-install.sh` on your development machine - it's the script that gets run on the target to run chef there.  Running it on your local machine will run your cookbook on your local machine, which is usually undesirable.

After installing, modify /etc/virtualbox/machines_enabled and add UIDs of machines you want to start at startup.