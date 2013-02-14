package :make_sites_path do
  user fetch(:user)
  
  runner "mkdir /var/www/sites"
  runner "chown #{user}:#{user} /var/www/sites"

  verify do
    has_path "/var/www/sites"
  end
end

package :install_rails_dependencies do
  description "Install libraries commonly required for rails development"
  apt 'libsqlite3-dev'
end

package :rails_development, :provides => :web_development do
  description 'Setup the box for web application development'
  
  requires :make_sites_path
  requires :install_rails_dependencies
end