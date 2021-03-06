class Post < ApplicationRecord
  extend FriendlyId

  serialize :images, JSON
  mount_uploaders :images, PostImageUploader

  friendly_id :title, use: :slugged

  validates :user_id, presence: true
  validates :title,   presence: true, length: { maximum: 100 }
  validates :body,    presence: true

  def short_body
    short = body.gsub(/\<.*?\>/, '')[0..200]
    short << '...' if body.length > 200
    short
  end
end
