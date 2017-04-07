module MessengerClient
  module Message
    QuickReply = Base.new(:id, :timestamp, :sender, :_postback, :_text)
  end
end
