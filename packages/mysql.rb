package :install_mysql do
  description 'MySQL Database Server and development libraries'
  apt 'mysql-server mysql-client' 

  verify do
    has_executable "mysqladmin"
  end
end

package :start_mysql do
  runner "service mysql start"
end

package :install_mysql_dev do
  description 'Ruby MySQL database driver'
  
  apt %w{libmysqlclient-dev}
end

package :mysql, :provides => :database do
  requires :install_mysql
  requires :start_mysql
  requires :install_mysql_dev
end
