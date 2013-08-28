Setup
=====

Install homebrew, then:

    brew install rbenv ruby-build
    echo 'eval "$(rbenv init -)"' >> ~/.bash_profile && source ~/.bash_profile
    rbenv rehash
    rbenv install 1.9.3-p385
    rbenv shell   1.9.3-p385
    rbenv global  1.9.3-p385
    gem install chef
    gem install berkshelf
    rbenv rehash
    mkdir project
    cd project
    knife solo init .
    vagrant init
    vagrant plugin install vagrant-omnibus
    vagrant plugin install vagrant-berkshelf

Optionally:

    gem install knife-solo

Create a cookbook
=================

* `knife cookbook create [cookbookname] -o local_cookbooks/`
* Add your cookbook to the Berksfile.
* Add your cookbook to the run_list in `nodes/default.json`.
* Optionally add a Berksfile to `local_cookbooks/[cookbookname]` with a `metadata` line to
  automatically fetch dependencies from metadata.rb.

Installation
============

Install to a server with:

    ./install.sh user@host.com [node.json]
