require File.expand_path("../button", __FILE__)

module MessengerClient
  class CallButton < Button
    def to_json
      {
        type:    "phone_number",
        title:   @text,
        payload: @data
      }
    end
  end
end

