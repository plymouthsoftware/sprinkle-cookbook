module Sprinkle::Package
  class Package
    @@capistrano = {}

    def capistrano
      @@capistrano
    end

    def self.set_variables=(set)
      @@capistrano = set
    end

    def self.fetch(name)
      @@capistrano[name]
    end

    def self.exists?(name)
      @@capistrano.key?(name)
    end

    def fetch(name)
      self.class.fetch(name)
    end

    def exists?(name)
      self.class.exists?(name)
    end
  end
end