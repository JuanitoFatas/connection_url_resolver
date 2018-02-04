# frozen_string_literal: true

require "uri"

class ConnectionUrlResolver
  class URIDecorator
    def initialize(url)
      @uri = parser.parse(url)
    end

    def to_hash
      connection_hash
    end

    private

      attr_reader :uri

      def parser
        @_parser ||= URI::Parser.new
      end

      def connection_hash
        unescape_values(connection_hash_with_values)
      end

      def connection_hash_with_values
        query_hash.merge(
          "adapter" => adapter,
          "username" => user,
          "password" => password,
          "port" => port,
          "database" => database,
          "host" => host
        ).reject { |_key, value| value.nil? || value.empty? }
      end

      def query_hash
        query.split("&").map { |pair| pair.split("=") }.to_h
      end

      def query
        uri.query || ""
      end

      def adapter
        @_adapter ||= begin
          adapter = uri.scheme && uri.scheme.tr("-", "_")

          if adapter == "postgres"
            "postgresql"
          else
            adapter
          end
        end
      end

      def user
        uri.user
      end

      def password
        uri.password
      end

      def port
        uri.port.to_s
      end

      def database
        if adapter == "sqlite3"
          uri.path
        else
          uri.path.sub %r(^/), ""
        end
      end

      def host
        uri.hostname
      end

      def unescape_values(hash)
        hash.transform_values { |value| unescape(value) }
      end

      def unescape(value)
        if value.is_a?(String)
          parser.unescape(value)
        end
      end
  end
end
