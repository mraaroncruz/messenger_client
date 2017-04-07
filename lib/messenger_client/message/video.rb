module MessengerClient
  module Message
    Video = Base.new(:id, :timestamp, :sender, :url)
  end
end
