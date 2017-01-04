class MessengerClient
  class QuickReply
    def initialize(text, payload=nil, image_url=nil)
      @text      = text
      @payload   = payload
      @image_url = image_url
    end

    def to_json
      json = {
        content_type: "text",
        title:        @text
      }
      json.merge!(payload: @payload)     unless @payload.nil?
      json.merge!(image_url: @image_url) unless @image_url.nil?
      json
    end
  end
end
