$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "universal-ar/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "universal-ar"
  s.version     = UniversalAr::VERSION
  s.authors     = ["Ben Petro"]
  s.email       = ["benpetro@gmail.com"]
  s.homepage    = ""
  s.summary     = "Summary of UniversalAr."
  s.description = "Description of UniversalAr."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.0.0", ">= 5.0.0.1"

end
