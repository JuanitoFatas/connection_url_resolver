require_relative "connection_url_resolver/version"
require_relative "connection_url_resolver/uri_decorator"

class ConnectionUrlResolver
  def initialize(url)
    raise NoURLError if url.empty?

    @uri = URIDecorator.new(url)
  end

  def to_hash
    uri.to_hash
  end

  private

    NoURLError = Class.new(ArgumentError)

    attr_reader :uri
end
