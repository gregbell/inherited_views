$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'rubygems'
require 'test/unit'
require 'mocha'

gem 'responders', '~> 0.4.6'

gem 'activesupport', '= 2.3.5'
require 'active_support'

gem 'actionpack', '= 2.3.5'
require 'action_controller'

class ApplicationController < ActionController::Base; end

require 'inherited_views'

ActionController::Routing::Routes.draw do |map|
  map.connect ':controller/:action/:id'
end