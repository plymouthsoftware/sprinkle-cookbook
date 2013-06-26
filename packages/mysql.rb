package :install_mysql do
  description 'MySQL Database Server and development libraries'
  apt 'mysql-server mysql-client' do
    post "service mysql start"
  end

  verify do
    has_executable "mysqladmin"
  end
end

package :install_mysql_dev do
  description 'Ruby MySQL database driver'
  
  apt %w{libmysqlclient-dev}
end

package :mysql, :provides => :database do
  requires :install_mysql
  requires :install_mysql_dev
end
