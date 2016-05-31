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

And require the gem manually:

```ruby
require 'piped_ruby'
```


## Usage

Print max element of a given array:
```ruby
array = [1, 3, 2, 5]
-> { array }.| { |e| e.length == 4 ? e.push(4) : e }
             .| { |e| e.max }
             .| { |e| puts e } # Prints: 5
```

Making some fun with strings:
```ruby
module Foo
  class << self
    def number; 1 end
    def answer(x); "So the answer of the life, the universe and everything is... #{x}!" end
  end
end

-> { Foo.number }.| { |e| e + 1 }
                 .| { |e| e * 21 }
                 .| { |e| Foo.answer(e) }
                 .| { |e| e + ' :-)' }
                 .| { |e| puts(e) } # Prints: So the answer of the life, the universe and everything is... 42!"
```


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/piped_ruby. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

