$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'rubygems'
require 'test/unit'

# Let's use mocha
require 'mocha'
include Mocha::API # So we can use stubs in this file

gem 'responders', '~> 0.4.6'

gem 'activesupport', '= 2.3.5'
require 'active_support'

gem 'actionpack', '= 2.3.5'
require 'action_controller'

class ApplicationController < ActionController::Base; end

require 'inherited_views'

# Manually setup will paginate for tests
WillPaginate.enable_actionpack


# Create a fake model for us to use
class User

  def self.content_columns
    @content_columns ||= [  stub(:name => "id"),
                            stub(:name => "username"),
                            stub(:name => "first_name"),
                            stub(:name => "last_name") ]
  end
  
  attr_accessor :id, :username, :first_name, :last_name
  
  def self.human_name; 'User'; end
  def initialize(attrs = {}); end
  def new_record?
    true
  end
  
  def errors; {} end
  
end


# Create a controller for us to use
class UsersController < InheritedViews::Base; end
ActionController::Routing::Routes.draw do |map|
  map.resources :users
  map.connect ':controller/:action/:id'
end
