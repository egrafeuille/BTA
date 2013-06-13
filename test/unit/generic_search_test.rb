require 'test_helper'

class GenericSearchTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "generic search empty is invalid test" do
    genericsearch = GenericSearch.new()
    assert genericsearch.invalid?
    assert genericsearch.errors[:city_from_id].any?
    assert genericsearch.errors[:city_to_id].any?
    assert genericsearch.errors[:priority].any?
  end
  
  test "generic search mandatory fields is valid test" do
    genericsearch = GenericSearch.new(:city_from_id => 1,
                                      :city_to_id => 2,
                                      :is_active => true,
                                      :priority => 1
                                      )
    assert genericsearch.valid?
    genericsearch.search_group_id = 1
    assert genericsearch.valid?
  end

  test "scope active test" do
    assert_equal GenericSearch.actives.count, 1
  end

  test "scope priority test" do
    assert_equal GenericSearch.priority(1).count, 2
  end

  test "scope active and priority test" do 
    assert_equal GenericSearch.actives.priority(1).count, 1
  end

#  test "valid generic search test" do
#    bsas = City.new(:name => "Buenos Aires")
#    rio  = City.new(:name => "Rio de Janeiro")
#    sg   = SearchGroup.new(:name => "Top Priority")
#    genericsearch = GenericSearch.new( :city_from_id => bsas.id,
#                                :city_to_id => rio.id,
#                                :is_active => true,
#                                :priority => 1,
#                                :search_group_id => sg.id
#                              )
#    assert genericsearch.invalid?
#    assert genericsearch.valid?
#  end

end
