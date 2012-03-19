require 'test_helper'

class PerformedtestsControllerTest < ActionController::TestCase
  setup do
    @performedtest = performedtests(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:performedtests)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create performedtest" do
    assert_difference('Performedtest.count') do
      post :create, :performedtest => @performedtest.attributes
    end

    assert_redirected_to performedtest_path(assigns(:performedtest))
  end

  test "should show performedtest" do
    get :show, :id => @performedtest.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @performedtest.to_param
    assert_response :success
  end

  test "should update performedtest" do
    put :update, :id => @performedtest.to_param, :performedtest => @performedtest.attributes
    assert_redirected_to performedtest_path(assigns(:performedtest))
  end

  test "should destroy performedtest" do
    assert_difference('Performedtest.count', -1) do
      delete :destroy, :id => @performedtest.to_param
    end

    assert_redirected_to performedtests_path
  end
end
