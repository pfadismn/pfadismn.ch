require 'test_helper'

class MailAliasesControllerTest < ActionController::TestCase
  setup do
    @mail_alias = mail_aliases(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:mail_aliases)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create mail_alias" do
    assert_difference('MailAlias.count') do
      post :create, mail_alias: { string: @mail_alias.string, string: @mail_alias.string }
    end

    assert_redirected_to mail_alias_path(assigns(:mail_alias))
  end

  test "should show mail_alias" do
    get :show, id: @mail_alias
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @mail_alias
    assert_response :success
  end

  test "should update mail_alias" do
    put :update, id: @mail_alias, mail_alias: { string: @mail_alias.string, string: @mail_alias.string }
    assert_redirected_to mail_alias_path(assigns(:mail_alias))
  end

  test "should destroy mail_alias" do
    assert_difference('MailAlias.count', -1) do
      delete :destroy, id: @mail_alias
    end

    assert_redirected_to mail_aliases_path
  end
end
