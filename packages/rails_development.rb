package :make_sites_path do
  user fetch(:user)
  
  runner "mkdir /var/www/sites"
  runner "chown #{user}:#{user} /var/www/sites"

  verify do
    has_path "/var/www/sites"
  end
end

package :create_rails_mysql_user do
  db_user "rails"
  db_password "password"
  db_name "app_development"

  runner "mysql -uroot -e \"create database #{db_name}; grant all on #{db_name}.* to #{db_user}@localhost identified by '#{db_password}';\""
end

package :rails_development, :provides => :web_development do
  description 'Setup the box for web application development'
  
  requires :make_sites_path
  requires :create_rails_mysql_user
end