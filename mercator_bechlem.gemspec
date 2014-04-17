$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "mercator_bechlem/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "mercator_bechlem"
  s.version     = MercatorBechlem::VERSION
  s.authors     = ["Stefan Haslinger"]
  s.email       = ["stefan.haslinger@informatom.com"]
  s.homepage    = "http://mercator.informatom.com"
  s.summary     = "MercatorMesonic provides Bechlem Crossselling Integration for the Mesonic Guided Selling Application."
  s.description = "MercatorMesonic interfaces between Mercator and Bechlem in the realm of product cross selling information."
  s.license    = "GPL-3.0"

  s.files = Dir["{app,config,db,lib}/**/*", "LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", '~> 4.0', '>= 4.0.3'
end