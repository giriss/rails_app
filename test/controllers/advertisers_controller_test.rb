require 'test_helper'

class AdvertisersControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get wallet" do
    get :wallet
    assert_response :success
  end

  test "should get campaign" do
    get :campaign
    assert_response :success
  end

  test "should get create_ad" do
    get :create_ad
    assert_response :success
  end

  test "should get tools" do
    get :tools
    assert_response :success
  end

  test "should get account" do
    get :account
    assert_response :success
  end

end
