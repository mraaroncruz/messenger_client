module MessengerClient
  class QuickReplies
    def initialize(text, quick_replies)
      @text          = text
      @quick_replies = parse_qrs(quick_replies)
    end

    def to_json
      {
        text: @text,
        quick_replies: @quick_replies
      }
    end

    private

    def parse_qrs(quick_replies)
      quick_replies.map(&:to_json)
    end
  end
end

