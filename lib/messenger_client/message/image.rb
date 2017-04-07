module MessengerClient
  module Message
    Image = Base.new(:id, :timestamp, :sender, :url, :sticker_id)
  end
end
