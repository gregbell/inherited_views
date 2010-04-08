require File.dirname(__FILE__) + '/test_helper'

class User
  def self.human_name; 'User'; end
end


class UsersController < InheritedViews::Base; end
UsersController.helper(InheritedViews::Helpers)

module UserTestHelper
  def setup
    @controller          = UsersController.new
    @controller.request  = @request  = ActionController::TestRequest.new
    @controller.response = @response = ActionController::TestResponse.new
    @controller.stubs(:user_url).returns("/")
  end

  protected
  
  def mock_user(expectations={})
    @mock_user ||= begin
      user = mock(expectations.except(:errors))
      user.stubs(:class).returns(User)
      user.stubs(:errors).returns(expectations.fetch(:errors, {})) 
      user
    end
  end
end

class IndexActionBaseTest < ActionController::TestCase
  
  include UserTestHelper
  
  def setup
    super
    User.expects(:find).with(:all).returns([mock_user])
    @columns = [  stub(:name => "username"),
                  stub(:name => "first_name"),
                  stub(:name => "last_name") ]
    User.stubs(:content_columns).returns(@columns)
    mock_user.stubs(:username => "john.doe", :first_name => "John", :last_name => "Doe")
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
    assert_select "td", "Doe"
  end
  
  test "should mark rows as odd and even" do
    assert_select "tr.odd"
  end
    
end