require 'test_helper'

class UrlActionControllerTest < ActionController::TestCase
  test "should get shrink" do
    get :shrink
    assert_response :success
  end

  test "should get delete" do
    get :delete
    assert_response :success
  end

end
