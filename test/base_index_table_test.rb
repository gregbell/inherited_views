require File.dirname(__FILE__) + '/test_helper'
require 'active_support/test_case'


class BaseIndexTableTest < ActiveSupport::TestCase
    
  test "should setup table columns by passing them all in" do
    UsersController.table :first_name, :last_name
    assert_equal [:first_name, :last_name], UsersController.new.send(:index_table_columns)
  end
  
  test "should allow us to render all except a specific column" do
    UsersController.table :except => :first_name
    assert_equal [:id, :username, :last_name], UsersController.new.send(:index_table_columns)
  end
  
end