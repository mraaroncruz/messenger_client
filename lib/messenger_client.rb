require "json"
require "typhoeus"

require "messenger_client/version"

# Buttons
require "messenger_client/button"
require "messenger_client/call_button"
require "messenger_client/login_button"
require "messenger_client/logout_button"
require "messenger_client/payload_button"
require "messenger_client/share_button"
require "messenger_client/url_button"

# Quick Replies
require "messenger_client/quick_replies"
require "messenger_client/quick_reply"

# Media
require "messenger_client/url_audio"
require "messenger_client/url_file"
require "messenger_client/url_image"
require "messenger_client/url_video"

# Location
require "messenger_client/location_template"

# Menu
require "messenger_client/menu_button"
require "messenger_client/menu"

# Get Started
require "messenger_client/get_started"

# Templates
require "messenger_client/button_template"
require "messenger_client/generic_template"

class MessengerClient
  URL_TEMPLATE = "https://graph.facebook.com/v2.6/me/messages?access_token=%s"

  def initialize(page_access_token)
    @page_access_token = page_access_token
  end

  def setup_menu(buttons)
    menu = Menu.new(buttons)
    post(menu.to_json)
  end

  def get_started(postback="get_started")
    gs = GetStarted.new(postback)
    post(gs.to_json)
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

  def generic_template(recipient_id:, template:)
  end

  private

  def send(recipient_id, data, opts={})
    payload = {
      recipient: {
        id: recipient_id
      }
    }
    payload.merge!(message: data) unless data.nil?
    payload.merge!(opts)
    Typhoeus.post(url, body: json(payload), headers: headers)
  end

  def post(payload)
    Typhoeus.post(url, body: json(payload), headers: headers)
  end

  def url
    URL_TEMPLATE % @page_access_token
  end

  def json(payload)
    JSON.dump(payload)
  end

  def headers
    { 'Accept-Encoding' => 'application/json',
      'Content-Type' => 'application/json' }
  end
end
