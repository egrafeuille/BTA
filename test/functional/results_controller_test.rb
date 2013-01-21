require 'test_helper'

class ResultsControllerTest < ActionController::TestCase
  setup do
    @result = results(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:results)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create result" do
    assert_difference('Result.count') do
      post :create, result: { airline_id: @result.airline_id, airport_from_id: @result.airport_from_id, airport_to_id: @result.airport_to_id, arrival: @result.arrival, currency: @result.currency, departure: @result.departure, price: @result.price, search_id: @result.search_id, source_id: @result.source_id, stops: @result.stops, traveltime: @result.traveltime }
    end

    assert_redirected_to result_path(assigns(:result))
  end

  test "should show result" do
    get :show, id: @result
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @result
    assert_response :success
  end

  test "should update result" do
    put :update, id: @result, result: { airline_id: @result.airline_id, airport_from_id: @result.airport_from_id, airport_to_id: @result.airport_to_id, arrival: @result.arrival, currency: @result.currency, departure: @result.departure, price: @result.price, search_id: @result.search_id, source_id: @result.source_id, stops: @result.stops, traveltime: @result.traveltime }
    assert_redirected_to result_path(assigns(:result))
  end

  test "should destroy result" do
    assert_difference('Result.count', -1) do
      delete :destroy, id: @result
    end

    assert_redirected_to results_path
  end
end
