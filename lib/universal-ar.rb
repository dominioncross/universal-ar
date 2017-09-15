require "universal-ar/engine"
require "universal-ar/config"
require "universal-ar/extensions"
require "universal-ar/sms_broadcast"
Gem.find_files("universal-ar/models/*.rb").each { |path| require path }
module UniversalAr
  # Your code goes here...
end
