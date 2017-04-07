module MessengerClient
  module Message
    Postback = Base.new(:timestamp, :sender, :_postback)
  end
end
