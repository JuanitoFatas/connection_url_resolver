RSpec.describe ConnectionUrlResolver do
  it "raises error when no url given" do
    expect do
      ConnectionUrlResolver.new("").to_hash
    end.to raise_error ConnectionUrlResolver::NoURLError
  end

  it "parses MySQL url correctly" do
    url = "mysql2://user:password@localhost:3306/app_dev"
    expected = {
      "adapter" => "mysql2",
      "host" => "localhost",
      "port" => "3306",
      "database" => "app_dev",
      "username" => "user",
      "password" => "password"
    }

    result = ConnectionUrlResolver.new(url).to_hash

    expect(result).to eq expected
  end

  it "parses PostgreSQL url correctly" do
    url = "postgres://user:password@localhost:5740/app_dev"
    expected = {
      "adapter" => "postgresql",
      "host" => "localhost",
      "port" => "5740",
      "database" => "app_dev",
      "username" => "user",
      "password" => "password",
    }

    result = ConnectionUrlResolver.new(url).to_hash

    expect(result).to eq expected
  end

  it "parses IPv6 host correctly" do
    url = "mysql://root@[::1]:3306/app_dev"

    result = ConnectionUrlResolver.new(url).to_hash

    expect(result["username"]).to eq "root"
    expect(result["host"]).to eq "::1"
    expect(result["port"]).to eq "3306"
  end

  it "parses query strings correctly" do
    url = "mysql://user:password@localhost/app_dev?encoding=utf8&pool=5"

    result = ConnectionUrlResolver.new(url).to_hash

    expect(result["encoding"]).to eq "utf8"
    expect(result["pool"]).to eq "5"
  end

  it "parses sqlite3 database correctly" do
    url = "sqlite:///Users/juanitofatas/app_dev.sqlite"

    result = ConnectionUrlResolver.new(url).to_hash

    expect(result["database"]).to eq "Users/juanitofatas/app_dev.sqlite"
  end
end
