#
# DevNull Storage
# by Hampton Catlin (@hcatlin)
#
#
# This storage type does *NOT* work.
# And, that's the point of the thing!
# Use this when you are in development 
# mode if you want the cache API to still
# be around, but you don't want it to store
# anything.
#
module Moneta
  class DevNull < Hash
    alias has_key? key?

    def store(key, value, options = {})
      nil
    end
    
    def []=(key, value)
      nil
    end
  end
end