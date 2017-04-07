module MessengerClient
  module Message
    class Base < Struct
      def postback;   respond_to?(:_postback) ? _postback : nil; end
      def text;       respond_to?(:_text)     ? _text     : nil; end
      def thumbs_up?; false                                      end
    end
  end
end
