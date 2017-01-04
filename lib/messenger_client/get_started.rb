module MessengerClient
  class GetStarted
    def initialize(postback="get_started")
      @postback = postback
    end

    def to_json
      {
        setting_type: "call_to_actions",
        thread_state: "new_thread",
        call_to_actions: [
          {
            payload: @postback
          }
        ]
      }
    end
  end
end
