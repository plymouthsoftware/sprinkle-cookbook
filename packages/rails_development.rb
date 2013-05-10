package :create_rails_mysql_user do
  db_user "rails"
  db_password "password"
  db_names ["app_development", "app_test"]

  db_names.each do |db_name|
    runner "mysql -uroot -e \"create database #{db_name}; grant all on #{db_name}.* to #{db_user}@localhost identified by '#{db_password}';\""
  end
end

package :rails_common_dependencies do
  apt "libxml2-dev libxslt1-dev libapache2-mod-xsendfile imagemagick"
end

package :rails_development, :provides => :web_development do
  description 'Setup the box for web application development'
  
  requires :rails_common_dependencies
  requires :create_rails_mysql_user
end