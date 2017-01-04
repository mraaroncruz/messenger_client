module MessengerClient
  class ButtonTemplate
    def initialize(text, buttons)
      @text    = text
      @buttons = parse_buttons(buttons)
    end

    def to_json
      {
        attachment: {
          type: "template",
          payload: {
            template_type: "button",
            text:          @text,
            buttons:       @buttons
          }
        }
      }
    end

    private

    def parse_buttons(buttons)
      buttons.map(&:to_json)
    end
  end
end
