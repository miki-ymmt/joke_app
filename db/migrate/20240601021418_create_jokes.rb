class CreateJokes < ActiveRecord::Migration[7.1]
  def change
    create_table :jokes do |t|
      t.text :content, null: false
      t.string :theme, null: false

      t.timestamps
    end
  end
end
