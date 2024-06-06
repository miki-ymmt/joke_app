class User < ApplicationRecord
  authenticates_with_sorcery!
  has_many :jokes, dependent: :destroy

  validates :name, length: { maximum:20}, presence: true
  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  validates :email, uniqueness: true

  def self.default_user
    find_or_create_by(email: 'guest@example.com') do |user|
      user.name = 'guest'
      user.password = 'password'
      user.password_confirmation = 'password'
    end
  end
end
