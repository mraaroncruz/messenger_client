module MessengerClient
  module Message
    Text = Base.new(:id, :timestamp, :sender, :_text)
  end
end
