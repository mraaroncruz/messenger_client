module MessengerClient
  class Template
    def initialize(template_items)
      @template_items = template_items
    end

    def type
      raise NotImplementedError
    end

    def to_json
      {
        attachment: {
          type: "template",
          payload: payload
        }
      }
    end

    private

    def payload
      {
        template_type: type,
        elements: @template_items.map(&:to_json),
      }
    end
  end
end

