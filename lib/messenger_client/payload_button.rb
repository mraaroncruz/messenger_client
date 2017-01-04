require File.expand_path("../button", __FILE__)

class MessengerClient
  class PayloadButton < Button
    def to_json
      {
        type:    "postback",
        title:   @text,
        payload: @data
      }
    end
  end
end

