require 'test_helper'

class ClaimParticularsControllerTest < ActionController::TestCase
  setup do
    @claim_particular = claim_particulars(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:claim_particulars)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create claim_particular" do
    assert_difference('ClaimParticular.count') do
      post :create, :claim_particular => @claim_particular.attributes
    end

    assert_redirected_to claim_particular_path(assigns(:claim_particular))
  end

  test "should show claim_particular" do
    get :show, :id => @claim_particular.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @claim_particular.to_param
    assert_response :success
  end

  test "should update claim_particular" do
    put :update, :id => @claim_particular.to_param, :claim_particular => @claim_particular.attributes
    assert_redirected_to claim_particular_path(assigns(:claim_particular))
  end

  test "should destroy claim_particular" do
    assert_difference('ClaimParticular.count', -1) do
      delete :destroy, :id => @claim_particular.to_param
    end

    assert_redirected_to claim_particulars_path
  end
end
