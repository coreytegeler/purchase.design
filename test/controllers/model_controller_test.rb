require 'test_helper'

class ModelControllerTest < ActionController::TestCase
  test "should get resources" do
    get :resources
    assert_response :success
  end

end
