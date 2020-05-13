class YouTubeService
  def video_info(id)
    params = { part: 'snippet,contentDetails,statistics', id: id }

    get_json('youtube/v3/videos', params)
  end

  def playlist_info(playlist_id)
    params = { part: 'snippet', id: playlist_id }

    get_json('youtube/v3/playlists', params)
  end

  def playlist_items(playlist_id)
    params = { part: 'snippet', maxResults: 50, playlistId: playlist_id }
    data = get_json('youtube/v3/playlistItems', params)
    return unless data[:nextPageToken]

    paginate_playlist_items(params, data)
  end

  private

  def get_json(url, params)
    response = conn.get(url, params)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: 'https://www.googleapis.com') do |f|
      f.adapter Faraday.default_adapter
      f.params[:key] = ENV['YOUTUBE_API_KEY']
    end
  end

  def paginate_playlist_items(params, data)
    while data[:nextPageToken]
      params[:pageToken] = data[:nextPageToken]
      next_page_data = get_json('youtube/v3/playlistItems', params)
      data[:items] += next_page_data[:items]
      data[:nextPageToken] = next_page_data[:nextPageToken]
    end
    data
  end
end
