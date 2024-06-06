class ChangeUserIdInJokesToNotNull < ActiveRecord::Migration[7.1]
  def change
    change_column_null :jokes, :user_id, false
  end
end
