module MessengerClient
  class Client
    URL_BASE     = "https://graph.facebook.com/v2.6/%s"
    URL_TEMPLATE = URL_BASE % "me/%s"

    def initialize(page_access_token)
      @page_access_token = page_access_token
      @logger            = MessengerClient::Config.logger
    end

    def set_get_started(postback="get_started")
      gs = GetStarted.new(postback)
      profile_post(gs.to_json)
    end

    def delete_get_started
      payload = { fields: ["get_started"] }
      delete(profile_url, payload)
    end

    def delete_persistent_menu
      payload = { fields: ["persistent_menu"] }
      delete(profile_url, payload)
    end

    def get_profile(facebook_id:, scopes:)
      scope_list = scopes.join(",")
      query = { fields: scope_list }
      url = URL_BASE % facebook_id
      get(url, query)
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

    def list_template(recipient_id:, template_items:, buttons: [])
      template = ListTemplate.new(template_items, buttons)
      send(recipient_id, template.to_json)
    end

    def generic_template(recipient_id:, template_items:)
      template = GenericTemplate.new(template_items)
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
      @logger.debug(message_url)   if ENV["DEBUG"]
      @logger.debug(json(payload)) if ENV["DEBUG"]
      @logger.debug(res.body)      if ENV["DEBUG"]
      @logger.debug(res.headers)   if ENV["DEBUG"]
      res
    end

    def post(payload, url = message_url)
      res = Typhoeus.post(url,  body: json(payload), params: { access_token: @page_access_token }, headers: headers)
      @logger.debug(url)           if ENV["DEBUG"]
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

    def get(url, query = {})
      res = Typhoeus.get(url, params: { access_token: @page_access_token }.merge(query), headers: headers)
      if !res.success?
        @logger.error("GET Request to #{url} with query #{query.inspect} Failed with #{res.code}")
      end
      res
    end

    def delete(url, payload)
      res = Typhoeus.delete(url, body: json(payload), params: { access_token: @page_access_token }, headers: headers)
      @logger.debug(url)           if ENV["DEBUG"]
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
