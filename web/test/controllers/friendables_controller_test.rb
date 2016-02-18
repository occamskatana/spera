require 'test_helper'

class FriendablesControllerTest < ActionController::TestCase
  test "should get friend_request" do
    get :friend_request
    assert_response :success
  end

end
