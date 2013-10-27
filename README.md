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

### With `knife` if you have Chef installed locally:

* `knife cookbook create [cookbookname] -o local_cookbooks/`
* Add your cookbook to the Berksfile.
* Add your cookbook to the run_list in `nodes/default.json`.
* Test your cookbook with `vagrant up` and `vagrant provision`.

### Without `knife`

    mkdir local_cookbooks/[cookbookname]
    cd local_cookbooks/[cookbookname]
    mkdir attributes
    touch attributes/default.rb
    mkdir recipes
    touch recipes/default.rb
    mkdir -p templates/default
    touch metadata.rb
    
Fill in metadata.rb as appropriate:

    name             'my project'
    maintainer       'me'
    maintainer_email 'me@me.com'
    license          'All rights reserved'
    description      'Installs/Configures my project'
    version          '0.1.0'
    depends          'apt'
    depends          'magic_shell'

Deploying to a server
=====================

Install to a server with:

    ./install.sh user@host.com [node.json]

Note that you do *not* want to run `chef-install.sh` on your development machine - it's the script that gets run on the target to run chef there.  Running it on your local machine will run your cookbook on your local machine, which is usually undesirable.

