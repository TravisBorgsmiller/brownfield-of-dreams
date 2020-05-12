class User < ApplicationRecord
  has_many :user_videos, dependent: :destroy
  has_many :videos, through: :user_videos
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships

  validates :email, uniqueness: true, presence: true
  validates :password, presence: true, on: :create
  validates :first_name, presence: true

  enum role: { default: 0, admin: 1 }

  has_secure_password

  def friendable?(gh_user)
    user = User.find_by(gh_uid: gh_user.uid)
    return false if user.nil?

    friends.exclude?(user)
  end
end
