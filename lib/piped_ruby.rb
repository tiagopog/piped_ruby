require 'piped_ruby/version'

module PipedRuby
  attr_accessor :piped

  def >>(&chained)
    self.piped = call if piped.nil?
    chained.piped = chained.call(piped)
    chained
  end

  def unwrap
    piped || call
  end
end

Proc.send :include, PipedRuby
