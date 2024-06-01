class Joke < ApplicationRecord
  validates :content, presence: true
  validates :content, length: { minimum: 100, maximum: 200}
  validates :content, uniqueness: true
  validates :theme, presence: true, inclusion: { in: %w(仕事 学校 家族 友達 食べ物 趣味 恋愛) }
end
