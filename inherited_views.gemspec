# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)
 
require 'inherited_views/version' 

Gem::Specification.new do |s|
  s.name        = "inherited_views"
  s.version     = InheritedViews::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Greg Bell"]
  s.email       = ["gregdbell@gmail.com"]
  s.homepage    = "http://github.com/gregbell/inherited_views"
  s.summary     = "The simplest way to implement REST controllers and views in rails applications"
  s.description = "InheritedViews brings the DRY principle to the controller and view layers within Rails applications" 

  s.add_dependency 'inherited_resources', '>= 1.0.6'
  s.add_dependency 'formtastic', '>= 0.9.8'
  
  s.add_development_dependency 'activesupport', '= 2.3.5'
  s.add_development_dependency 'actionpack', '= 2.3.5'
  s.add_development_dependency 'mocha'
 
  s.files        = Dir.glob("lib/**/*") + %w(LICENSE README.rdoc)
  s.require_path = 'lib'
end