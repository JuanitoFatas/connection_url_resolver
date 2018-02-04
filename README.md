# ConnectionUrlResolver

[![Build Status](https://travis-ci.org/JuanitoFatas/connection_url_resolver.svg?branch=master)](https://travis-ci.org/JuanitoFatas/connection_url_resolver)

Resolve connection URL into Hash.

## Installation

Add this line to your application's Gemfile:

```ruby
gem "connection_url_resolver"
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install connection_url_resolver

## Usage

```ruby
url = "mysql2://user:password@localhost:3306/app_dev"
ConnectionUrlResolver.new(url).to_hash
# =>
{
  "adapter" => "mysql2",
  "username" => "user",
  "password" => "password",
  "port" => "3306",
  "database" => "app_dev",
  "host" => "localhost"
}
```

## License, Contributor's Guidelines

- [MIT license][mit]
- [Moya Contributors Guidelines][moya] which TLDR: means we give out push access easily and often.

[mit]: https://opensource.org/licenses/MIT
[moya]: https://github.com/Moya/contributors
