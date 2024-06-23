require "test_helper"

class GenkiControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get genki_index_url
    assert_response :success
  end
end
