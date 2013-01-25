require 'test_helper'

class SummariesControllerTest < ActionController::TestCase
  setup do
    @summary = summaries(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:summaries)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create summary" do
    assert_difference('Summary.count') do
      post :create, summary: { airline_id: @summary.airline_id, city_from_id: @summary.city_from_id, city_to_id: @summary.city_to_id, currency: @summary.currency, price: @summary.price, search_id: @summary.search_id, source_id: @summary.source_id, stops: @summary.stops }
    end

    assert_redirected_to summary_path(assigns(:summary))
  end

  test "should show summary" do
    get :show, id: @summary
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @summary
    assert_response :success
  end

  test "should update summary" do
    put :update, id: @summary, summary: { airline_id: @summary.airline_id, city_from_id: @summary.city_from_id, city_to_id: @summary.city_to_id, currency: @summary.currency, price: @summary.price, search_id: @summary.search_id, source_id: @summary.source_id, stops: @summary.stops }
    assert_redirected_to summary_path(assigns(:summary))
  end

  test "should destroy summary" do
    assert_difference('Summary.count', -1) do
      delete :destroy, id: @summary
    end

    assert_redirected_to summaries_path
  end
end
