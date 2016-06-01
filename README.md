# Piped Ruby

```ruby
-> { "Pipe" }.| { |e| "#{e} things"  }
             .| { |e| "#{e} in Ruby! " }
             .| { |e| e =~ /ruby/i ? e * 2 : e }
             .unwrap #=> "Pipe things in Ruby! Pipe things in Ruby! "
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

Pipe operations happen between Proc objects (blocks). After requiring the gem every Proc in your Ruby program will be capable to start a pipe operation.

```ruby
operation = -> { 'Foo' }.| { |e| "#{e}bar" }
operation.class #=> Proc
operation.unwrap #=> "Foobar"
```

The `PipedRuby#unwrap` method is the way to get the returning value from the last evaluated block:

```ruby
operation = -> { 'Foo' }.| { |e| "#{e}bar" }
operation.| { |e| puts e } #=> Prints "Foobar" and returns a Proc object
operation.| { |e| puts e }.unwrap #=> Prints "Foobar" and returns nil
```


## Examples

Get max element of a given array:
```ruby
array = [1, 2, 3, 4]
-> { array }.| { |e| e.length == 4 ? e.push(5) : e }
            .| { |e| e.max }
            .unwrap #=> 5
```

Get some cool quote:
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
                 .unwrap #=> "So the answer of the life, the universe and everything is... 42! :-)"
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/piped_ruby. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

