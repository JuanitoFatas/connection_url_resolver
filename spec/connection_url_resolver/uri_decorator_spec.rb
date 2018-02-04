RSpec.describe ConnectionUrlResolver::URIDecorator do
  URIDecorator = ConnectionUrlResolver::URIDecorator

  it "no value is empty from returned hash" do
    url = "mysql://user:password@localhost/app_dev?encoding=utf8&pool=5"

    result = URIDecorator.new(url).to_hash

    expect(result.values.size).to eq result.values.compact.size
  end

  it "postgres protocol returns postgresql" do
    url = "postgres://user:password@localhost/app_dev"

    result = URIDecorator.new(url).to_hash

    expect(result["adapter"]).to eq "postgresql"
  end

  it "no double leading slashes for database" do
    url = "mysql://user:password@localhost//Users/juanitofatas/app_dev"

    result = URIDecorator.new(url).to_hash

    expect(result["database"]).to eq "/Users/juanitofatas/app_dev"
  end

  it "unescapes escaped characters" do
    url = "postgres://%2Fvar%2Flib%2Fpostgresql/app_dev"

    result = URIDecorator.new(url).to_hash

    expect(result["host"]).to eq "/var/lib/postgresql"
  end
end
