class RemoveNotNullConstraintFromJokesTitle < ActiveRecord::Migration[7.1]
  class Joke < ApplicationRecord
  end
  def up
    change_column_null :jokes, :title, true
  end

  def down
    change_column_null :jokes, :title, false
  end
end
