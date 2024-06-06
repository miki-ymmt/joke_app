class ChangeUserIdInJokesToNullable < ActiveRecord::Migration[7.1]
  def change
    change_column_null :jokes, :user_id, true
  end
end
