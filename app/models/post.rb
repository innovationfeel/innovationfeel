class Post < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  validates :user_id, presence: true
  validates :title,   presence: true, length: { maximum: 100 }
  validates :body,    presence: true
end