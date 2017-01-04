module MessengerClient
  class URLVideo
    def initialize(url)
      @url = url
    end

    def to_json
      {
        attachment: {
          type: "video",
          payload: {
            url: @url
          }
        }
      }
    end
  end
end
