package :make_sites_path do
  user = fetch(:user)
  
  runner "mkdir -p /var/www/sites"
  runner "chown #{user}:#{user} /var/www/sites"

  verify do
    test "-d /var/www/sites"
  end
end

package :install_apache2 do
  apt 'apache2 apache2.2-common apache2-mpm-prefork apache2-utils libexpat1 ssl-cert' do
    post :install, 'chown -R www-data:www-data /var/www'

    post :install, 'a2enmod rewrite'
    post :install, 'a2dissite default'
    post :install, 'service apache2 restart'
  end

  verify do
    has_executable '/usr/sbin/apache2'
  end
end

package :apache2, :provides => :webserver do
  description 'Install the apache2 Web Application server and setup /var/www/sites'

  requires :make_sites_path
  requires :install_apache2
end