package :install_rbenv do
  description 'Ruby RBEnv'
  user fetch(:user)

  runner  "sudo -u #{user} -i git clone git://github.com/sstephenson/rbenv.git /home/#{user}/.rbenv"
  runner "sudo -u #{user} -i git clone git://github.com/sstephenson/ruby-build.git /home/#{user}/.rbenv/plugins/ruby-build"

  push_text 'export PATH="$HOME/.rbenv/bin:$PATH"', "/home/#{user}/.profile"
  push_text 'eval "$(rbenv init -)"', "/home/#{user}/.profile"

  runner "chown '#{user}' /home/#{user}/.profile"

  verify do
    has_executable "/home/#{user}/.rbenv/bin/rbenv"
  end
end

package :install_ruby do
  requires :install_rbenv
  version fetch(:ruby_version)
  user fetch(:user)

  runner "sudo -u #{user} -i rbenv install #{version}"
  runner "sudo -u #{user} -i rbenv rehash"

  verify do
    has_executable "/home/#{user}/.rbenv/shims/ruby"
  end
end

package :rbenv_bundler do
  requires :use_rbenv

  runner "sudo -u #{user} -i gem install bundler"
  runner "sudo -u #{user} -i rbenv rehash"

  verify do 
    @commands << "gem list | grep bundler"
  end
end

package :use_rbenv do
  requires :install_ruby

  version fetch(:ruby_version)
  user fetch(:user)

  runner "sudo -u #{user} -i rbenv rehash"
  runner "sudo -u #{user} -i rbenv global #{version}"
  runner "sudo -u #{user} -i rbenv rehash"
end

package :install_rubygems do
  requires :use_rbenv

  description 'Ruby Gems Package Management System'
  version '1.8.25'
  user fetch(:user)

  source "http://production.cf.rubygems.org/rubygems/rubygems-#{version}.tgz" do
    custom_install "sudo -u #{user} -i ruby setup.rb"
    
    # post :install, "ln -s /usr/bin/gem1.8 /usr/bin/gem"
    post :install, "sudo -u #{user} -i gem update --system"
  end

  verify do
    has_executable "/home/#{user}/.rbenv/shims/gem"
  end
end

package :install_bundler do
  requires :use_rbenv
  requires :install_rubygems

  user fetch(:user)

  runner "sudo -u #{user} -i gem install bundler --no-rdoc --no-ri"
  runner "sudo -u #{user} -i rbenv rehash"
  
  verify do
    has_executable "/home/#{user}/.rbenv/shims/bundle"
  end
end

package :ruby_essentials do
  apt 'libssl-dev zlib1g zlib1g-dev libreadline-dev'
end

package :ruby_rbenv do
  requires :ruby_essentials
  requires :install_rubygems
  requires :install_bundler
end