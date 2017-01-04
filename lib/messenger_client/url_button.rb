require File.expand_path("../button", __FILE__)

class MessengerClient
  class URLButton < Button
    def to_json
      {
        type:  "web_url",
        title: @text,
        url:   @data
      }
    end
  end
end

