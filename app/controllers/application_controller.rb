class ApplicationController < ActionController::Base
  before_action :require_login


#current_userメソッドを定義する
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  private

  def not_authenticated
    redirect_to login_path, alert: "ログインしてください"
  end
end
