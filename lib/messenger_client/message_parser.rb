module MessengerClient
  class MessageParser
    attr_reader :payload
    # Takes in JSON parsed Hash from facebook
    def initialize(payload)
      @payload = payload
    end

    # Parses Hash messages in payload into list of appropriate Message type
    def parse
      e = payload["entry"].first
      e["messaging"].map { |message|
        parse_message(message)
      }.compact
    end

    def parse_message(message)
      sender = MessengerClient::Message::Sender.new(message["sender"]["id"])
      timestamp = message["timestamp"]
      m = message["message"]
      if m.nil?
        return parse_postback(message, timestamp, sender)
      end
      if attchs = m["attachments"]
        attch = attchs.first
        pl    = attch["payload"]
        url   = pl["url"]
        case attch["type"]
        when "image"
          if sid = pl["sticker_id"]
            MessengerClient::Message::Sticker.new(m["mid"], timestamp, sender, url, sid)
          else
            MessengerClient::Message::Image.new(m["mid"], timestamp, sender, url)
          end
        when "video"
          MessengerClient::Message::Video.new(m["mid"], timestamp, sender, url)
        when "audio"
          MessengerClient::Message::Audio.new(m["mid"], timestamp, sender, url)
        when "file"
          MessengerClient::Message::File.new(m["mid"], timestamp, sender, url)
        when "location"
          url = attch["url"]
          lat, lng = pl["coordinates"]["lat"], pl["coordinates"]["long"]
          MessengerClient::Message::Location.new(m["mid"], timestamp, sender, url, lat, lng)
        else
        end
      else
        parse_non_media(m, timestamp, sender)
      end
    end

    def parse_non_media(message, timestamp, sender)
      if qr = message["quick_reply"]
        payload = qr["payload"].to_sym
        return MessengerClient::Message::QuickReply.new(message["mid"], timestamp, sender, payload, message["text"])
      end
      if txt = message["text"]
        return MessengerClient::Message::Text.new(message["mid"], timestamp, sender, txt)
      end
      return nil
    end

    def parse_postback(message, timestamp, sender)
      if pb = message["postback"]
        payload = pb["payload"].to_sym
        return MessengerClient::Message::Postback.new(timestamp, sender, payload)
      end
      return nil
    end
  end
end
