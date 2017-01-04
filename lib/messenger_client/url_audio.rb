class MessengerClient
  class URLAudio
    def initialize(url)
      @url = url
    end

    def to_json
      {
        attachment: {
          type: "audio",
          payload: {
            url: @url
          }
        }
      }
    end
  end
end
