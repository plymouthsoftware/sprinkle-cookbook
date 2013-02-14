# Sprinkle Cookbook

A set of recipes and configurations for configuring servers with Sprinkle.

## Installation

To use with Vagrant, download and install Vagrant from http://www.vagrantup.com/

    $ gem install sprinkle

    $ mkdir myproject
    $ cd myproject

    $ rails new app # Example. This folder is shared to the VM as /var/www/sites/app
    
    $ git clone git@github.com:plymouthsoftware/sprinkle-cookbook.git
    $ cd sprinkle-cookbook
    $ vagrant up
    
    $ sprinkle -c -s config/install.rb

    # Log into your virtual machine
    $ vagrant ssh 

    (vm) $ cd /var/www/app
    (vm) $ bundle install
    (vm) $ bundle exec rails generate scaffold users name:string email:string
    (vm) $ bundle exec rake db:migrate
    (vm) $ bundle exec rails server

On host machine, visit http://localhost:3030/ in your browser