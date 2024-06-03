class UpdateExistingJokesSetDefaultTitleAndAddNotNullConstraint < ActiveRecord::Migration[7.1]
  class Joke < ApplicationRecord
  end

  def up
    #既存のnull値を持つtitleにデフォルトのタイトルを設定
    Joke.where(title: nil).update_all(title: "おばちゃんのジョーク")

    #titleカラムにnull制約を追加
    change_column_null :jokes, :title, false
  end

  def down
    # null: false制約を削除
    change_column_null :jokes, :title, true
  end
end
