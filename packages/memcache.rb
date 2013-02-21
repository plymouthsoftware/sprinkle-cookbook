package :install_memcached do
  user fetch(:user)

  apt "memcached" do
    post :install, "sudo -u #{user} -i service start memcached"
  end
end

package :memcache, :provides => :cache_server do
  description 'Install a local memcache service to provide caching'
  
  requires :install_memcached
end