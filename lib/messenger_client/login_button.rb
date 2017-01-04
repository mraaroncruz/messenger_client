module MessengerClient
  class LoginButton
    def initialize(url)
      @url = url
    end

    def to_json
      {
        type: "account_link",
        url:  @url
      }
    end
  end
end

