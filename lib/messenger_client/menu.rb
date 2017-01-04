module MessengerClient
  class Menu
    def initialize(buttons)
      @text    = text
      @buttons = parse_buttons(buttons)
    end

    def to_json
      {
        setting_type:    "call_to_actions",
        thread_state:    "existing_thread",
        call_to_actions: parse_buttons(@buttons)
      }
    end

    private

    def parse_buttons(buttons)
      buttons.map(&:to_json)
    end
  end
end


