require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get create" do
    get :create
    assert_response :success
  end

  test "should get destroy" do
    get :destroy
    assert_response :success
  end

  test "should get request_new" do
    get :request_new
    assert_response :success
  end

  test "should get password" do
    get :password
    assert_response :success
  end

end
