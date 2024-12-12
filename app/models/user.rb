class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable, :confirmable, :trackable

  has_many :folders, dependent: :destroy
  has_many :feed_subscriptions, dependent: :destroy
  has_many :feeds, through: :feed_subscriptions
end
