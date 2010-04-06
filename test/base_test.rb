require File.dirname(__FILE__) + '/test_helper'

class User
  def self.human_name; 'User'; end
end


class UsersController < InheritedViews::Base; end

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
    get :index    
  end
  
  test "should render a nice heading" do
    assert_select "h1", "Users"
  end
    
end