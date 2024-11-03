# frozen_string_literal: true
# typed: strict

require_relative "init"
require_relative "scanner"

class Lox
  sig { params(args: T::Array[String]).void }
  def self.exec(args)
    if args.size > 1
      puts "Usage: rblox [script]"
      exit(64)
    elsif args.size == 1
      run_file(T.must(args[0]))
    else
      run_prompt
    end
  end

  sig { params(path: String).void }
  def self.run_file(path)
    puts "path: #{path}"
  end

  sig { void }
  def self.run_prompt
    puts "running prompt"

    loop do
      print("> ")
      input = gets
      if input.chomp.empty?
        break
      end

      # puts(input.chomp)
      run(input.chomp)
    end
  end

  sig { params(source: String).void }
  private_class_method def self.run(source)
    scanner = Scanner.new(source)
    tokens = scanner.scan_tokens

    tokens.each do |token|
      puts token
    end
  end
end

if __FILE__ == $0
  Lox.exec(ARGV)
end
