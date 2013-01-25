require 'test_helper'

class SearchGroupsControllerTest < ActionController::TestCase
  setup do
    @search_group = search_groups(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:search_groups)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create search_group" do
    assert_difference('SearchGroup.count') do
      post :create, search_group: { name: @search_group.name }
    end

    assert_redirected_to search_group_path(assigns(:search_group))
  end

  test "should show search_group" do
    get :show, id: @search_group
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @search_group
    assert_response :success
  end

  test "should update search_group" do
    put :update, id: @search_group, search_group: { name: @search_group.name }
    assert_redirected_to search_group_path(assigns(:search_group))
  end

  test "should destroy search_group" do
    assert_difference('SearchGroup.count', -1) do
      delete :destroy, id: @search_group
    end

    assert_redirected_to search_groups_path
  end
end
