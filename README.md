# Piped Ruby

```ruby
-> { "Pipe" }.| { |e| "#{e} things"  }
             .| { |e| "#{e} in Ruby!" }
             .unwrap #=> "Pipe things in Ruby!"
```

Piped Ruby is a tiny piece of code that aims to bring the beauty of pipe operators and data transformation to your Ruby application.

Credit to [Elixir's Pipe Operator](http://elixir-lang.org/getting-started/enumerables-and-streams.html#the-pipe-operator) and [Chainable Methods](https://github.com/akitaonrails/chainable_methods) gem which were the source of inspiration for this gem :-)

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

With Piped Ruby doing this:

```ruby
-> { some_text.upcase }.>> { |e| MyModule.method_a(e)  }
                       .>> { |e| MyModule.method_b(e, "something") }
                       .>> { |e| MyModule.method_c(e) { |c| do_something3(c) } }
                       .unwrap
```

...is equivalent to this:

```ruby
a = some_text.upcase
b = MyModule.method_a(a)
c = MyModule.method_b(b, "something")
d = MyModule.method_c(c) { |c| do_something3(c) }
```

### More examples

Exporting clients from CSV file:

```ruby
#...
def call
  File.foreach(file) do |line|
    -> { values_from(line) }
      .>> { |e| match_fields_for(e) }
      .>> { |e| sanitize(e) }
      .>> { |e| Save.new(attributes: sanitize(e)) }
      .>> { |save| save.call }
      .unwrap
  end
end
```

Fun with strings:

```ruby
module Foo
  class << self
    def number; 1 end
    def answer(x); "So the answer of the life, the universe and everything is... #{x}!" end
  end
end

-> { Foo.number }.>> { |e| e + 1 }
                 .>> { |e| e * 21 }
                 .>> { |e| Foo.answer(e) }
                 .>> { |e| e + ' :-)' }
                 .unwrap #=> "So the answer of the life, the universe and everything is... 42! :-)"
```


## Backstage

Pipe operations happen between Proc objects (blocks). After requiring the gem every Proc in your Ruby program will be capable to start a pipe operation.

```ruby
operation = -> { 'Foo' }.>> { |e| "#{e}bar" }
operation.class #=> Proc
operation.unwrap #=> "Foobar"
```

The `PipedRuby#unwrap` method is the way to get the returning value from the last evaluated block:

```ruby
operation = -> { 'Foo' }.>> { |e| "#{e}bar" }
operation.>> { |e| puts e } #=> Prints "Foobar" and returns a Proc object
operation.>> { |e| puts e }.unwrap #=> Prints "Foobar" and returns nil
```

## TODO

- [ ] Write more cool examples in README;
- [ ] Introduce something similar to Elixir's Streams;
- [ ] Store Procs and be able to unwrap a returning value in different points of execution.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/piped_ruby. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

