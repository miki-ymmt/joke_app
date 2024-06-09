class ApplicationController < ActionController::Base
  before_action :require_login


#current_userメソッドを定義する
  def current_user
    begin
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
    rescue ActiveRecord::RecordNotFound  #エラーが発生してもプログラムが停止しないようにする
      nil  #ユーザーが存在しない場合にはcurrent_userメソッドがnilを返すようにする
    end
  end

  private

  def not_authenticated
    redirect_to login_path, alert: "ログインしてください"
  end
end
