class User < ApplicationRecord
  has_many :user_videos, dependent: :destroy
  has_many :videos, through: :user_videos

  has_many :followers, foreign_key: :follower_id , class_name: "Friendship"
  has_many :followed, through: :followers
  has_many :followed, foreign_key: :followed_id, class_name: "Friendship"
  has_many :followers, through: :followed

  validates :email, uniqueness: true, presence: true
  validates :password, presence: true, on: :create
  validates :first_name, presence: true
  enum role: { default: 0, admin: 1 }
  has_secure_password
end
