module MessengerClient
  class GetStarted
    def initialize(postback="get_started")
      @postback = postback
    end

    def to_json
      {
        get_started: {
          payload: @postback
        }
      }
    end
  end
end
