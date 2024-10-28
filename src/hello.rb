# frozen_string_literal: true
# typed: strict
require 'sorbet-runtime'
extend T::Sig

sig { void }
def hello
  puts "world"
end

hello
