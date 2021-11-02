require "test_helper"

class FavoritingsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get favoritings_create_url
    assert_response :success
  end

  test "should get destroy" do
    get favoritings_destroy_url
    assert_response :success
  end
end
