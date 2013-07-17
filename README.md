# Sprinkle Cookbook

A set of recipes and configurations for configuring servers with [Sprinkle](https://github.com/crafterm/sprinkle).

## Installation

1. To use with Vagrant, download and install [Vagrant](http://www.vagrantup.com/)

        $ gem install sprinkle

        $ mkdir myproject
        $ cd myproject
        $ mkdir app # This folder is shared to the VM as /var/www/sites/app in Vagrantfile

        $ git clone git@github.com:plymouthsoftware/sprinkle-cookbook.git
        $ cd sprinkle-cookbook

2. Edit `config/deploy.rb` to your requirements:

        $ cp config/deploy.rb.example config/deploy.rb

    For example, change the server `role` to the policy stack you want to use, e.g:

        # config/deploy.rb
        role :rails_dev, 'localhost:2222'

3. Edit `Vagrantfile` to your requirements:

        $ cp Vagrantfile.example Vagrantfile

4. Create your vagrant box and run your desired Sprinkle cookbook

        $ vagrant up
        $ sprinkle -c -s config/install.rb --only=rails_dev # The role you declared in deploy.rb
    
## Policies 

### Rails Development

Log into your new Virtual Machine and configure a simple Rails app

    $ vagrant up
    $ sprinkle -c -s config/install.rb
    $ vagrant ssh 

    (vm) $ cd ~/app
    (vm) $ rails new app --database mysql 
    (vm) $ cd app
    (vm) $ bundle install # Probably already run by rails new
    (vm) $ bundle exec rails generate scaffold users name:string email:string
    (vm) $ bundle exec rake db:migrate
    (vm) $ bundle exec rails server

On host machine, visit http://192.168.33.11/users in your browser

## Changes

### 17 July 2013

* Changed to use Vagrant v2 configuration.
* Switched from public_network to private (host-only) network (default IP is `192.168.33.100`)
* Updated default app path to /home/vagrant/app rather than /var/www/apps/.