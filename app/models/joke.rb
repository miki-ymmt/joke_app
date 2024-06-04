class Joke < ApplicationRecord
  validates :content, presence: true, length: { minimum: 100, maximum: 200}
  validates :theme, presence: true, inclusion: { in: %w(仕事 学校 家族 友達 食べ物 趣味 恋愛) }
  validates :title, length: { minimum: 1, maximum: 20 }, allow_nil: true
end
