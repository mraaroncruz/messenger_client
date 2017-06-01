module MessengerClient
  class ListTemplate < Template
    TEMPLATE_STYLES = %w(LARGE COMPACT)

    def initialize(template_items, buttons = [], style = "LARGE")
      @template_items = template_items
      @buttons        = buttons
      @style          = style.upcase
    end

    def type
      "list"
    end

    def payload
      data = {
        template_type: type,
        elements: @template_items.map(&:to_json),
      }

      raise ArgumentError, "#{@style} is not a valid template style. Your choices are #{TEMPLATE_STYLES.join(', ')}" unless TEMPLATE_STYLES.include?(@style)
      data.merge!(top_element_style: @style)

      data.merge!(buttons: @buttons.map(&:to_json)) if @buttons.any?
      data
    end
  end
end
