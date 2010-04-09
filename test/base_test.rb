require File.dirname(__FILE__) + '/test_helper'
require 'action_view/test_case'

# Create a fake model for us to use
class User
  def self.human_name; 'User'; end
end


# Create a controller for us to use
class UsersController < InheritedViews::Base; end
UsersController.helper(InheritedViews::Helpers)    
ActionController::Routing::Routes.draw do |map|
  map.resources :users
end

module UserTestHelper
  
  def create_mock_user(expectations={})
      user = mock(expectations.except(:errors))
      user.stubs(:class).returns(User)
      user.stubs(:errors).returns(expectations.fetch(:errors, {})) 
      user
  end
end

class IndexActionBaseTest < ActionController::TestCase
  
  include UserTestHelper
  
  tests UsersController
  
  def setup
    super    
    mock_user_1 = create_mock_user
    mock_user_2 = create_mock_user
    User.expects(:find).with(:all).returns([mock_user_1, mock_user_2])
    @columns = [  stub(:name => "username"),
                  stub(:name => "first_name"),
                  stub(:name => "last_name") ]
    User.stubs(:content_columns).returns(@columns)
    mock_user_1.stubs(:username => "john.doe", :first_name => "John", :last_name => "Doe")
    mock_user_2.stubs(:username => "jane.doe", :first_name => "Jane", :last_name => "Doe")
    get :index
    # puts @controller.response.body
  end
  
  test "should render a nice heading" do
    assert_select "h2", "Users"
  end
  
  test "should id and class the index table" do
    assert_select "table#users_index_table"
    assert_select "table.index_table"
  end
  
  test "should render a table with the attributes of the model" do
    assert_select "th", "Username"
    assert_select "th", "First Name"
    assert_select "th", "Last Name"
  end
  
  test "should render each resource" do
    assert_select "td", "john.doe"
    assert_select "td", "John"
    assert_select "td", "jane.doe"
    assert_select "td", "Jane"
    assert_select "td", "Doe"
  end
  
  test "should mark rows as odd and even" do
    assert_select "tr.odd"
    assert_select "tr.even"
  end
  
  test "should render using the table partial" do
    assert_template :partial => "_table", :count => 1
  end
  
  test "should generate edit links" do
    assert_select "a", "Edit", :count => 2
  end
  
  test "should generate delete links" do
    assert_select "a", "Delete", :count => 2
  end
  
end