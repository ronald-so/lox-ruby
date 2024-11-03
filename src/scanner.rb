# frozen_string_literal: true
# typed: strict

require_relative "init"

class Scanner
  sig { params(source: String).void }
  def initialize(source)
    @source = source
  end

  sig { returns(T::Array[T.untyped]) }
  def scan_tokens
    []
  end
end
