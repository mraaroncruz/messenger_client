module MessengerClient
  class URLFile
    def initialize(url)
      @url = url
    end

    def to_json
      {
        attachment: {
          type: "file",
          payload: {
            url: @url
          }
        }
      }
    end
  end
end
