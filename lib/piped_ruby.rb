require 'piped_ruby/version'

module PipedRuby
  attr_accessor :to_pipe, :piped

  def >>(&chained)
    self.to_pipe = call if to_pipe.nil?

    chained.piped   = to_pipe
    chained.to_pipe = chained.call(to_pipe)

    chained
  end

  def unwrap
    to_pipe || call(piped)
  rescue ArgumentError
    call
  end
end

Proc.send :include, PipedRuby
