package :install_php do
  description 'PHP5'
  user fetch(:user)

  apt %w(libapache2-mod-php5 php5 php5-common php5-curl php5-dev php5-gd php5-imagick php5-mcrypt php5-memcache php5-mhash php5-mysql php5-pspell php5-snmp php5-sqlite php5-xmlrpc php5-xsl) do
    # post :install, "sudo -u #{user} -i /etc/init.d/apache2 force-restart"
  end

  verify do
    has_file "/etc/apache2/mods-enabled/php5.conf"
    has_file "/etc/apache2/mods-enabled/php5.load"
  end
end

package :php, :provides => :web_development do
  requires :install_php
end
