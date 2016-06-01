require 'piped_ruby/version'

module PipedRuby
  attr_accessor :piped

  alias_method :unwrap, :piped

  def |(&chained)
    self.piped = call if piped.nil?
    chained.piped = chained.call(piped)
    chained
  end
end

Proc.send :include, PipedRuby
