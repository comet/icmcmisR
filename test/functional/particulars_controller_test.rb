require 'test_helper'

class ParticularsControllerTest < ActionController::TestCase
  setup do
    @particular = particulars(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:particulars)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create particular" do
    assert_difference('Particular.count') do
      post :create, :particular => @particular.attributes
    end

    assert_redirected_to particular_path(assigns(:particular))
  end

  test "should show particular" do
    get :show, :id => @particular.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @particular.to_param
    assert_response :success
  end

  test "should update particular" do
    put :update, :id => @particular.to_param, :particular => @particular.attributes
    assert_redirected_to particular_path(assigns(:particular))
  end

  test "should destroy particular" do
    assert_difference('Particular.count', -1) do
      delete :destroy, :id => @particular.to_param
    end

    assert_redirected_to particulars_path
  end
end
