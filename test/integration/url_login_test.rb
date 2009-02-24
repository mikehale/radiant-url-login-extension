require File.dirname(__FILE__) + '/../test_helper'

class UrlLoginTest < ActionController::IntegrationTest
  scenario :users

  def test_login_succeeds
    user = users(:existing)
    user.login_tokens << 'GoodToken'
    user.save!

    redirect_url = '/admin/preview/1'
    get "/login/GoodToken/#{redirect_url.encode}"
    assert_redirected_to redirect_url
    user.reload

    assert_equal [], user.login_tokens
    assert_equal user, controller.send(:current_user)
  end
end