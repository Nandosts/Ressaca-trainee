require 'test_helper'

class PurchaseProductsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get purchase_products_create_url
    assert_response :success
  end

  test "should get destroy" do
    get purchase_products_destroy_url
    assert_response :success
  end

end
