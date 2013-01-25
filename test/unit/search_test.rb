require 'test_helper'

class SearchTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  test "search basic test" do
    bsas = City.new(:name => "Buenos Aires")
    rio  = City.new(:name => "Rio de Janeiro")
    dep  = Date.today
    ret  = dep + 3
    search = Search.new(:city_from_id => bsas.id,
                        :city_to_id => rio.id,
                        :departure => dep,
                        :return =>  ret,
                        :active => "Y",
                        :priority => 1
                          )
    assert search.valid?
  end
end
