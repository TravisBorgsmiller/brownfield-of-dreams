module YouTube
  class Video
    attr_reader :thumbnail, :title, :description, :id, :position

    def initialize(data = {})
      @title = data[:snippet][:title]
      @description = data[:snippet][:description]
      @thumbnail = data[:snippet][:thumbnails][:high][:url]
      @id = data[:id]
      @position = data[:position] || 0
    end

    def self.by_id(id)
      new(YouTubeService.new.video_info(id)[:items][0])
    end

    def self.import_from_playlist(playlist_id)
      videos = YouTubeService.new.playlist_items(playlist_id)
      videos[:items].map.with_index do |video_hash, index|
        video_hash[:id] = video_hash[:snippet][:resourceId][:videoId]
        video_hash[:position] = index
        YouTube::Video.new(video_hash)
      end
    end
  end
end
