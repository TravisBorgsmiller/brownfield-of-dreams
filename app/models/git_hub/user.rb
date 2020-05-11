module GitHub
  class User
    attr_reader :login, :url, :uid

    def initialize(attributes)
      @login = attributes[:login]
      @url = attributes[:html_url]
      @uid = attributes[:id]
    end

    def registered_user?
      ::User.find_by(gh_uid: @uid).present?
    end
  end
end
