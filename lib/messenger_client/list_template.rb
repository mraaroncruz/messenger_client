module MessengerClient
  class ListTemplate < Template
    def initialize(template_items, buttons = [])
      @template_items = template_items
      @buttons = buttons
    end

    def type
      "list"
    end

    def payload
      data = {
        template_type: type,
        elements: @template_items.map(&:to_json),
      }

      data.merge!(buttons: @buttons.map(&:to_json)) if @buttons.any?
      data
    end
  end
end
