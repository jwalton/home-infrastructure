Setup
=====

* Install virtualbox and vagrant
* `vagrant plugin install vagrant-omnibus`
* `vagrant plugin install vagrant-berkshelf`

You don't *need* to have Ruby or Chef installed on your development machine at all, but optionally install rbenv and ruby-build, then:
    echo 'eval "$(rbenv init -)"' >> ~/.bash_profile && source ~/.bash_profile
    rbenv rehash
    rbenv install 1.9.3-p385
    rbenv shell   1.9.3-p385
    rbenv global  1.9.3-p385
    gem install chef
    gem install berkshelf
    gem install foodcritic # Handy for sanity-checking your cookbooks.
    gem install knife-solo
    rbenv rehash

Create a cookbook
=================

* `knife cookbook create [cookbookname] -o local_cookbooks/`
* Add your cookbook to the Berksfile.
* Add your cookbook to the run_list in `nodes/default.json`.
* Test your cookbook with `vagrant up` and `vagrant provision`.

Deploying to a server
=====================

Install to a server with:

    ./install.sh user@host.com [node.json]

Note that you do *not* want to run `chef-install.sh` on your development machine - it's the script that gets run on the target to run chef there.  Running it on your local machine will run your cookbook on your local machine, which is usually undesirable.

