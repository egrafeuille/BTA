require 'test_helper'

class RouteTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "route empty is invalid test" do
    route = Route.new()
    assert route.invalid?
    assert route.errors[:city_from_id].any?
    assert route.errors[:city_to_id].any?
    assert route.errors[:info_priority].any?
  end
  
  test "route mandatory fields is valid test" do
    route = Route.new(:city_from_id => 1,
                      :city_to_id => 10,
                      :is_active => true,
                      :info_priority => 1
                                      )
    assert route.valid?
  end

  test "route uniqueness test" do
    route = Route.new(:city_from_id => 1,
                      :city_to_id => 2,
                      :is_active => true,
                      :info_priority => 1
                                      )
    assert route.invalid?
    assert route.errors[:city_from_id].any?
  end


  test "route scope active test" do
    assert_equal Route.actives.count, 2
  end

  test "route scope priority test" do
    assert_equal Route.info_priority(1).count, 2
  end

  test "route scope active and priority test" do 
    assert_equal Route.actives.info_priority(1).count, 1
  end
  
end
