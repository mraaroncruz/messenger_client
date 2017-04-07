module MessengerClient
  module Message
    Location = Base.new(:id, :timestamp, :sender, :url, :lat, :lng)
  end
end
