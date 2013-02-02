require 'test_helper'

class SearchDatesControllerTest < ActionController::TestCase
  setup do
    @search_date = search_dates(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:search_dates)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create search_date" do
    assert_difference('SearchDate.count') do
      post :create, search_date: { departure: @search_date.departure, is_active: @search_date.is_active, return: @search_date.return }
    end

    assert_redirected_to search_date_path(assigns(:search_date))
  end

  test "should show search_date" do
    get :show, id: @search_date
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @search_date
    assert_response :success
  end

  test "should update search_date" do
    put :update, id: @search_date, search_date: { departure: @search_date.departure, is_active: @search_date.is_active, return: @search_date.return }
    assert_redirected_to search_date_path(assigns(:search_date))
  end

  test "should destroy search_date" do
    assert_difference('SearchDate.count', -1) do
      delete :destroy, id: @search_date
    end

    assert_redirected_to search_dates_path
  end
end
