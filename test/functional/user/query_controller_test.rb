require 'test_helper'

class User::QueryControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get old" do
    get :old
    assert_response :success
  end

  test "should get history" do
    get :history
    assert_response :success
  end

end
