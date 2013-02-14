package :apache2, :provides => :webserver do
  description 'Apache2 Web Application server'
  
  apt 'apache2 apache2.2-common apache2-mpm-prefork apache2-utils libexpat1 ssl-cert' do
    post :install, 'a2enmod rewrite'
    post :install, 'a2dissite default'
    post :install, 'service apache2 restart'
  end

  verify do
    has_executable '/usr/sbin/apache2'
  end
end