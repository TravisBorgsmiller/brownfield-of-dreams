class Video < ApplicationRecord
  has_many :user_videos, dependent: :destroy
  has_many :users, through: :user_videos
  belongs_to :tutorial

  def self.import_from_yt(id, tutorial)
    yt_video = YouTube::Video.by_id(id)
    Video.create(
      title: yt_video.title,
      description: yt_video.description,
      thumbnail: yt_video.thumbnail,
      video_id: yt_video.id,
      position: yt_video.position,
      tutorial: tutorial
    )
  end
end
