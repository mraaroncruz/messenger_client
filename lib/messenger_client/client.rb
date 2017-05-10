module MessengerClient
  class Client
    URL_TEMPLATE = "https://graph.facebook.com/v2.6/me/%s"

    def initialize(page_access_token)
      @page_access_token = page_access_token
      @logger            = MessengerClient::Config.logger
    end

    def get_started(postback="get_started")
      gs = GetStarted.new(postback)
      profile_post(gs.to_json)
    end

    def text(recipient_id:, text:)
      send(recipient_id, text: text)
    end

    def qr(recipient_id:, text:, replies:)
      qr_template = QuickReplies.new(text, replies)
      send(recipient_id, qr_template.to_json)
    end

    def button_template(recipient_id:, text:, buttons:)
      template = ButtonTemplate.new(text, buttons)
      send(recipient_id, template.to_json)
    end

    def generic_template(recipient_id:, title:, subtitle: nil, image_url: nil, default_url: nil, buttons: [])
      template = GenericTemplate.new(title, subtitle, image_url, default_url,  buttons)
      send(recipient_id, template.to_json)
    end

    def image(recipient_id:, url:)
      media = URLImage.new(url)
      send(recipient_id, media.to_json)
    end

    def video(recipient_id:, url:)
      media = URLVideo.new(url)
      send(recipient_id, media.to_json)
    end

    def audio(recipient_id:, url:)
      media = URLAudio.new(url)
      send(recipient_id, media.to_json)
    end

    def file(recipient_id:, url:)
      media = URLFile.new(url)
      send(recipient_id, media.to_json)
    end

    def youtube_video(recipient_id:, url:)
      text(recipient_id: recipient_id, text: url)
    end

    def location(recipient_id:)
      loc = MessengerClient::LocationTemplate.new
      send(recipient_id, loc.to_json)
    end

    def typing(recipient_id:, seconds:, &blk)
      send(recipient_id, nil, sender_action: "typing_on", mark_seen: "true")
      if seconds > 0
        sleep(seconds)
        if block_given?
          blk.call
        end
      end
    end

    def send(recipient_id, data, opts={})
      payload = {
        recipient: {
          id: recipient_id
        }
      }
      payload.merge!(message: data) unless data.nil?
      payload.merge!(opts)
      res = Typhoeus.post(message_url, body: json(payload), params: { access_token: @page_access_token }, headers: headers)
      @logger.debug(message_url)           if ENV["DEBUG"]
      @logger.debug(json(payload)) if ENV["DEBUG"]
      @logger.debug(res.body)      if ENV["DEBUG"]
      @logger.debug(res.headers)   if ENV["DEBUG"]
      res
    end

    def post(payload)
      res = Typhoeus.post(message_url, body: json(payload), params: { access_token: @page_access_token }, headers: headers)
      @logger.debug(message_url)           if ENV["DEBUG"]
      @logger.debug(json(payload)) if ENV["DEBUG"]
      @logger.debug(res.body)      if ENV["DEBUG"]
      @logger.debug(res.headers)   if ENV["DEBUG"]
      res
    end

    def profile_post(payload)
      res = Typhoeus.post(profile_url, body: json(payload), params: { access_token: @page_access_token }, headers: headers)
      @logger.debug(profile_url)   if ENV["DEBUG"]
      @logger.debug(json(payload)) if ENV["DEBUG"]
      @logger.debug(res.body)      if ENV["DEBUG"]
      @logger.debug(res.headers)   if ENV["DEBUG"]
      res
    end

    private

    def message_url
      URL_TEMPLATE % "messages"
    end

    def profile_url
      URL_TEMPLATE % "messenger_profile"
    end

    def json(payload)
      JSON.dump(payload)
    end

    def headers
      { 'Accept-Encoding' => 'application/json',
        'Content-Type'    => 'application/json' }
    end
  end
end
