module MessengerClient
  class ListTemplate < Template
    TEMPLATE_STYLES = %w(plain)

    def initialize(template_items, buttons = [], style = nil)
      @template_items = template_items
      @buttons = buttons
      @style = style
    end

    def type
      "list"
    end

    def payload
      data = {
        template_type: type,
        elements: @template_items.map(&:to_json),
      }

      if !@style.nil?
        raise ArgumentError, "#{@style} is not a valid template style" unless TEMPLATE_STYLES.include?(@style)
        data.merge!(top_element_style: @style)
      end

      data.merge!(buttons: @buttons.map(&:to_json)) if @buttons.any?
      data
    end
  end
end
