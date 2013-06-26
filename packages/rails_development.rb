DB_USER = "rails"
DB_PASS = "password"
DB_NAMES = ["app_development", "app_test"]

package :make_sites_path do
  user = fetch(:user)
  
  runner "mkdir -p /var/www/sites"
  runner "chown #{user}:#{user} /var/www/sites"

  # verify do
  #   has_path "/var/www/sites/"
  # end
end

package :create_rails_mysql_user do
  db_user = DB_USER
  db_password = DB_PASS

  runner "mysql -uroot -e \"CREATE USER #{db_user}@localhost identified by '#{db_password}';\""

  verify do
    test "`mysql -B -N -uroot -e \"SELECT COUNT(*) FROM mysql.user WHERE User=\\\"#{db_user}\\\";\"` -eq 1;"
  end
end

package :create_rails_databases do
  db_user = DB_USER
  db_password = DB_PASS

  DB_NAMES.each do |db_name|
    runner "mysql -uroot -e \"CREATE DATABASE IF NOT EXISTS #{db_name}; grant all on #{db_name}.* to #{db_user}@localhost identified by '#{db_password}';\""
  end

  verify do
    DB_NAMES.each do |db_name|
      test "-d /var/lib/mysql/#{db_name}"
    end
  end
end

package :rails_common_dependencies do
  apt "libxml2-dev libxslt1-dev libapache2-mod-xsendfile imagemagick"
end

package :ruby_mysql_dependencies, :provides => :ruby_database_dependencies do
  apt "libmysql-ruby"
end

package :rails_development, :provides => :web_development do
  description 'Setup the box for web application development'
  
  requires :rails_common_dependencies
  requires :ruby_database_dependencies
  requires :make_sites_path
  requires :create_rails_mysql_user
  requires :create_rails_databases
end