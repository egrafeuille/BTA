require 'test_helper'

class ResultTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "result empty is invalid test" do
    r = Result.new()
    assert r.invalid?
    assert r.errors[:route_id].any?
    assert r.errors[:source_id].any?
    assert r.errors[:airport_from_id].any?
    assert r.errors[:airport_to_id].any?
    assert r.errors[:departure].any?
    assert r.errors[:stops].any?
    assert r.errors[:currency].any?
    assert r.errors[:price].any?
    assert r.errors[:result_type].any?
    assert r.errors[:result_date].any?
  end

  test "result mandatory fields is valid test" do
    r = Result.new(
                  :route_id => 1,
                  :source_id => 1,
                  :airport_from_id => 1,
                  :airport_to_id => 2,
                  :departure => DateTime.now,
              #    :returndate => 1,
              #    :airline_id => 1,
                  :stops => 0,
                  :currency => "ARS",
                  :price => 9.99,
              #    :traveltime => 1,
                  :ticket_class => " ",
                  :is_roundtrip => true,
                  :result_type => "Res",
                  :result_date => DateTime.now
    )
    assert r.valid?, r.errors.full_messages.inspect
  end

  test "result airports differ test" do
    r = Result.new(
                  :route_id => 1,
                  :source_id => 1,
                  :airport_from_id => 1,
                  :airport_to_id => 1,
                  :departure => DateTime.now,
              #    :returndate => 1,
              #    :airline_id => 1,
                  :stops => 0,
                  :currency => "ARS",
                  :price => 9.99,
              #    :traveltime => 1,
                  :ticket_class => " ",
                  :is_roundtrip => true,
                  :result_type => "Res",
                  :result_date => DateTime.now
    )
    assert r.invalid?
    assert r.errors[:airport_to_id].any?
  end

#  test "route scope active test" do
#    assert_equal Route.actives.count, 2
#  end

#  test "route scope priority test" do
#    assert_equal Route.info_priority(1).count, 2
#  end

#  test "route scope active and priority test" do
#    assert_equal Route.actives.info_priority(1).count, 1
#  end

end
