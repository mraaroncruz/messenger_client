module MessengerClient
  class LogoutButton
    def initialize
    end

    def to_json
      {
        type: "account_unlink"
      }
    end
  end
end

