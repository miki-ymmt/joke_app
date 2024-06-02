class AddTitleToJokes < ActiveRecord::Migration[7.1]
  def change
    add_column :jokes, :title, :string
  end
end
