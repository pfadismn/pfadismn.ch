require 'test_helper'

class AbteilungControllerTest < ActionController::TestCase
  test "should get wolfsstufe" do
    get :wolfsstufe
    assert_response :success
  end

  test "should get biberstufe" do
    get :biberstufe
    assert_response :success
  end

  test "should get pfadistufe" do
    get :pfadistufe
    assert_response :success
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get roverstufe" do
    get :roverstufe
    assert_response :success
  end

  test "should get apv" do
    get :apv
    assert_response :success
  end

end
