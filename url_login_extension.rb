class UrlLoginExtension < Radiant::Extension
  version "1.0"
  description "Log the user in with a secret token in the url and optionally redirect them to a specified page."

  define_routes do |map|
    map.connect 'login/:token', :controller => '/url_login'
    map.connect 'login/:token/*url', :controller => '/url_login'
  end

  def activate
    User.class_eval do
      serialize :login_tokens, Array

      def generate_token(size)
        chars = ((' '[0]..'~'[0]).to_a.collect{|e| e.chr} - %w(' " \\ ` /))
        (0...size).inject(''){ |memo,_| memo << chars.sort_by{rand}.first }
      end

      def create_token!
        token = generate_token(6).encode
        login_tokens << token
        self.save!
        token
      end
    end

    String.class_eval do
      def encode
        self.to_a.pack('m').chomp
      end
    end

    Array.class_eval do
      def decode
        self.first.unpack('m').first
      end
    end

  end
end