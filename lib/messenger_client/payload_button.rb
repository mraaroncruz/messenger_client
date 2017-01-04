require File.expand_path("../button", __FILE__)

module MessengerClient
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

