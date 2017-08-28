require 'test_helper'

class Admin::StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_static_pages_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_static_pages_show_url
    assert_response :success
  end

  test "should get home" do
    get admin_static_pages_home_url
    assert_response :success
  end

end
