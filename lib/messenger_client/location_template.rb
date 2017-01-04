class MessengerClient
  class LocationTemplate
    def initialize(text)
      @text = text
    end

    def to_json
      {
        text: @text,
        quick_replies: {
          content_type: "location"
        }
      }
    end
  end
end
