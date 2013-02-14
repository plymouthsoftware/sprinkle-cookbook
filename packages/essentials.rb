package :remove_legacy_ruby do
  runner "rm -rf /opt/vagrant_ruby" # Remove built in ruby from Vagrant boxes
end

package :git do
  apt 'git-core build-essential' 
end

package :bootstrap, :provides => :essentials do
  requires :remove_legacy_ruby
  requires :git
end