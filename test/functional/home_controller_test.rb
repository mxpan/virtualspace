require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  test "should get inspire" do
    get :inspire
    assert_response :success
  end

end
