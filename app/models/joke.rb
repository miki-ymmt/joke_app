class Joke < ApplicationRecord
  belongs_to :user

  validates :content, presence: true, length: { minimum: 100, maximum: 200}
  validates :theme, presence: true, inclusion: { in: %w(仕事 学校 家族 友達 食べ物 趣味 恋愛) }
  validates :title, length: { minimum: 1, maximum: 20 }, allow_nil: true

  def self.searchable_attributes
    %w(content theme title) # 検索可能な属性をここに列挙
  end

  searchable_attributes.each do |field|
    scope "search_by_#{field}", ->(keyword) { where("#{field} LIKE ?", "%#{keyword}%") }
  end

  def self.ransackable_associations(auth_object = nil)
    ["user"]  #検索できる関連モデルを制限する
  end

  def self.ransackable_attributes(auth_object = nil)  #特定のユーザー（または他の認証オブジェクト）が検索できる属性を制限する
    %w(content theme title) # 検索可能な属性をここに列挙
  end
end
