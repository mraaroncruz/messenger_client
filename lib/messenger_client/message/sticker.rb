module MessengerClient
  module Message
    Sticker = Base.new(:id, :timestamp, :sender, :url, :sticker_id) do
      THUMBS = {
        "369239263222822" => :small,
        "369239343222814" => :medium,
        "369239383222810" => :large,
      }

      def thumbs_up?
        !!thumb_size
      end

      def thumb_size
        THUMBS[sticker_id.to_s]
      end
    end
  end
end
