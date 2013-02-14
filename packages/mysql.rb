package :install_mysql do
  description 'MySQL Database Server and development libraries'
  apt 'mysql-server mysql-client'

  verify do
    has_executable "mysql"
  end
end

package :install_mysql_ruby do
  description 'Ruby MySQL database driver'
  
  apt %w{libmysqlclient-dev libmysql-ruby}
end

package :mysql, :provides => :database do
  requires :install_mysql
  requires :install_mysql_ruby
end
