class Tutorial < ApplicationRecord
  has_many :videos, -> { order(position: :ASC) }, inverse_of: :tutorial
  acts_as_taggable_on :tags, :tag_list
  accepts_nested_attributes_for :videos

  def self.import_from_playlist(playlist_id)
    yt_playlist = YouTube::Playlist.import(playlist_id)
    @tutorial = create_playlist(yt_playlist)

    yt_videos = YouTube::Video.import_from_playlist(playlist_id)
    create_videos(yt_videos)
    @tutorial
  end

  def self.create_videos(yt_videos)
    yt_videos.each do |yt_video|
      Video.create(
        title: yt_video.title,
        description: yt_video.description,
        thumbnail: yt_video.thumbnail,
        video_id: yt_video.id,
        tutorial: @tutorial
      )
    end
  end

  def self.create_playlist(yt_playlist)
    Tutorial.new(
      title: yt_playlist.title,
      description: yt_playlist.description,
      thumbnail: yt_playlist.thumbnail,
      playlist_id: yt_playlist.id
    )
  end
end
