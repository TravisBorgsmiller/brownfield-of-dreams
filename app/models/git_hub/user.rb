module GitHub
  class User
    attr_reader :login, :url, :uid

    def initialize(attributes)
      @login = attributes[:login]
      @url = attributes[:html_url]
      @uid = attributes[:id]
    end

    def friendable?
      user = User.find_by(gh_uid: @uid)
      user.present? && user.followers.include?(current_user)
    end
  end
end
