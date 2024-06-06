class AddUserToJokes < ActiveRecord::Migration[7.1]
  def change
    add_reference :jokes, :user, null: true, foreign_key: true
  end
end
