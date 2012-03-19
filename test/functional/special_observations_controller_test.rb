require 'test_helper'

class SpecialObservationsControllerTest < ActionController::TestCase
  setup do
    @special_observation = special_observations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:special_observations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create special_observation" do
    assert_difference('SpecialObservation.count') do
      post :create, :special_observation => @special_observation.attributes
    end

    assert_redirected_to special_observation_path(assigns(:special_observation))
  end

  test "should show special_observation" do
    get :show, :id => @special_observation.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @special_observation.to_param
    assert_response :success
  end

  test "should update special_observation" do
    put :update, :id => @special_observation.to_param, :special_observation => @special_observation.attributes
    assert_redirected_to special_observation_path(assigns(:special_observation))
  end

  test "should destroy special_observation" do
    assert_difference('SpecialObservation.count', -1) do
      delete :destroy, :id => @special_observation.to_param
    end

    assert_redirected_to special_observations_path
  end
end
