class MessengerClient
  class URLImage
    def initialize(url)
      @url = url
    end

    def to_json
      {
        attachment: {
          type: "image",
          payload: {
            url: @url
          }
        }
      }
    end
  end
end
