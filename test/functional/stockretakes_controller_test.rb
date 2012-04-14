require 'test_helper'

class StockretakesControllerTest < ActionController::TestCase
  setup do
    @stockretake = stockretakes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:stockretakes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create stockretake" do
    assert_difference('Stockretake.count') do
      post :create, :stockretake => @stockretake.attributes
    end

    assert_redirected_to stockretake_path(assigns(:stockretake))
  end

  test "should show stockretake" do
    get :show, :id => @stockretake.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @stockretake.to_param
    assert_response :success
  end

  test "should update stockretake" do
    put :update, :id => @stockretake.to_param, :stockretake => @stockretake.attributes
    assert_redirected_to stockretake_path(assigns(:stockretake))
  end

  test "should destroy stockretake" do
    assert_difference('Stockretake.count', -1) do
      delete :destroy, :id => @stockretake.to_param
    end

    assert_redirected_to stockretakes_path
  end
end
