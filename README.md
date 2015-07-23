What is it?
===========
This is the ansible script I use to provision my home servers:

* galactica - a VM host which runs other servers via VirtualBox and Docker.

Testing with Vagrant
====================

* Install virtualbox and vagrant
* Install ansible v1.9.x or higher
* `ansible-galaxy install -r requirements.yml`
* `vagrant up` to create a VM

If you want to test galactica, you should edit the Vagrantfile and change "default.json" to "galactica.json".
Similar for other servers.

Prerequisites when creating a new server
========================================

### Server

If you're installing the VM server, then you need a computer with Ubuntu Server 14.04.2 installed
(or similar).  Run `sudo apt-get update` on the server before you do anything else.  Create an
ssh keypair if you don't already have one:

    ssh-keygen -t rsa -C "your_email@example.com"

And then copy your key to the host, either with:

    ssh-copy-id user@host

or:

    scp ~/.ssh/id_rsa.pub user@host:~/.ssh/authorized_keys


Deploying to a server
=====================

Edit ansible/hosts with the name of the server to deploy to, then install with:

    install.sh
