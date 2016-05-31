# Piped Ruby

```ruby
-> { "Pipe" }.| { |e| "#{e} things"  }
             .| { |e| "#{e} in Ruby!" }
             .| { |e| puts e } # Pipe things in Ruby!
```

Piped Ruby is a tiny piece of code that brings an awesome feature to Ruby: pipe operators.

Credit to [Elixir's pipe operator](http://elixir-lang.org/getting-started/enumerables-and-streams.html#the-pipe-operator) that is the source of inspiration for this gem :-)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'piped_ruby'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install piped_ruby

## Usage

TODO: Write usage instructions here


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/piped_ruby. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

