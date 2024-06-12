class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[new create]
  before_action :set_user, only: %i[show edit update destroy]
  before_action :authorize_user, only: %i[edit update destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      auto_login(@user)
      redirect_to jokes_path, notice: "アカウントを作成しました"
    else
      #logger.debug @user.errors.full_messages.join(", ") #デバッグ用
      flash.now[:alert] = "アカウントを作成できませんでした"
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @jokes = @user.jokes.page(params[:page]).order(created_at: :desc).per(6)
  end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to user_path(current_user), notice: "アカウント情報を更新しました"
    else
      flash.now[:alert] = "アカウント情報を更新できませんでした"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    reset_session
    redirect_to root_path, status: :see_other, notice: "アカウントを削除しました"
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :avatar, :avatar_cache)
  end

  def authorize_user
    redirect_to user_path(current_user), alert: "他のユーザーの情報は編集できません" if @user != current_user
  end
end