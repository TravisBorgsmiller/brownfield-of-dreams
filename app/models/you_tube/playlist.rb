module YouTube
  class Playlist
    attr_reader :title, :description, :thumbnail, :id

    def initialize(data = {})
      @title = data[:items][0][:snippet][:title]
      @description = data[:items][0][:snippet][:description]
      @thumbnail = data[:items][0][:snippet][:thumbnails][:high][:url]
      @id = data[:items][0][:id]
    end

    def self.import(playlist_id)
      new(YouTubeService.new.playlist_info(playlist_id))
    end
  end
end
