class UrlLoginController < ApplicationController
  no_login_required
  skip_before_filter :verify_authenticity_token

  def index
    login_with_token(params[:token])
    params[:url] ? redirect_to(params[:url].decode) : redirect_to('/admin')
  end

  def login_with_token(token)
    unless current_user
      if user = User.find(:all).detect {|user| user.login_tokens.include?(token) }
        user.login_tokens.delete(token)
        user.save!
        self.current_user = user
        self.send(:set_current_user)
      end
    end
  end

end