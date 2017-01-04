class MessengerClient
  class ShareButton
    def initialize
    end

    def to_json
      {
        type: "element_share"
      }
    end
  end
end

