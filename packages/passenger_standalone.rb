package :passenger_standalone, :provides => :appserver do
  description 'Passenger Standalone'
  user = fetch(:user)

  requires :use_rbenv

  apt "libcurl4-openssl-dev"

  runner "sudo -u #{user} -i gem install passenger --no-ri --no-rdoc" do
    post :install, "sudo -u #{user} -i rbenv rehash"
  end

  verify do
    has_executable "/home/#{user}/.rbenv/shims/passenger"
  end
end