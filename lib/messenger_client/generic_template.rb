module MessengerClient
  class GenericTemplate
    def initialize(title, subtitle = nil, image_url = nil, default_url = nil, buttons = [])
      @title       = title
      @subtitle    = subtitle
      @image_url   = image_url
      @default_url = default_url
      @buttons     = buttons
    end

    def to_json
      payload = {
        template_type: "generic",
        title: @title,
      }

      payload.merge!(subtitle: @subtitle) unless @subtitle.nil?
      payload.merge!(image_url: @image_url) unless @image_url.nil?
      payload.merge!(default_action: parse_default_action(@default_url)) unless @default_url.nil?
      payload.merge!(buttons: parse_buttons(@buttons)) unless @buttons.empty?

      {
        attachment: {
          type: "template",
          payload: payload
        }
      }
    end

    private

    def parse_default_action(url)
      {
        type: "web_url",
        url:  url,
      }
    end

    def parse_buttons(buttons)
      buttons.map(&:to_json)
    end
  end
end
