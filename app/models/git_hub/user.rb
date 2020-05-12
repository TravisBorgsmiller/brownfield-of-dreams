module GitHub
  class User
    attr_reader :login, :url, :uid

    def initialize(attributes)
      @login = attributes[:login]
      @url = attributes[:html_url]
      @uid = attributes[:id]
    end
  end
end
