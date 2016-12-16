require "universal-ar/engine"
require "universal-ar/extensions"
Gem.find_files("universal-ar/models/*.rb").each { |path| require path }
module UniversalAr
  # Your code goes here...
end
