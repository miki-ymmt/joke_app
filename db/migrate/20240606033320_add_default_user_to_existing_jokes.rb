class AddDefaultUserToExistingJokes < ActiveRecord::Migration[7.1]
  def up #デフォルトユーザーを追加
    default_user = User.find_or_create_by(email: 'guest@example.com') do |user|
      user.name = 'guest'
      user.password = 'password'
      user.password_confirmation = 'password'
    end

    #既存のジョークにデフォルトユーザーを紐付ける
    Joke.where(user_id: nil).update_all(user_id: default_user.id)
  end

  def down
  end
end
