require 'test_helper'

class GenericSearchesControllerTest < ActionController::TestCase
  setup do
    @generic_search = generic_searches(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:generic_searches)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create search" do
    assert_difference('GenericSearch.count') do
      post :create, generic_search: { active: @generic_search.active, return: @generic_search.return, departure: @generic_search.departure, priority: @generic_search.priority }
    end

    assert_redirected_to generic_search_path(assigns(:generic_search))
  end

  test "should show search" do
    get :show, id: @generic_search
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @generic_search
    assert_response :success
  end

  test "should update search" do
    put :update, id: @generic_search, generic_search: { active: @generic_search.active, return: @generic_search.return, departure: @generic_search.departure, priority: @generic_search.priority }
    assert_redirected_to generic_search_path(assigns(:generic_search))
  end

  test "should destroy search" do
    assert_difference('GenericSearch.count', -1) do
      delete :destroy, id: @generic_search
    end

    assert_redirected_to generic_searches_path
  end
end
