class Item < ApplicationRecord
  belongs_to :feed

  validates :title, :url, :published_at, presence: true
  validates :url, uniqueness: true
end
