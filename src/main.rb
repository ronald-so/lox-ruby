# frozen_string_literal: true
# typed: strict

require_relative "init"
require_relative "scanner"

class Lox
  @@had_error = T.let(false, T::Boolean)

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
    file = File.open(path)
    data = T.let(file.read, String)
    run(data)

    if @@had_error
      exit(65)
    end
  end

  sig { void }
  def self.run_prompt
    puts "running prompt"

    loop do
      print("> ")
      begin
        input = readline
      rescue EOFError
        break
      end

      run(input.chomp)
      @@had_error = false
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

  sig { params(line: Integer, message: String).void }
  def self.error(line, message)
    report(line, "", message)
  end

  sig do
    params(line: Integer, where: String, message: String).void
  end
  private_class_method def self.report(line, where, message)
    STDOUT.puts "[line #{line}] Error#{where}: #{message}"
    @@had_error = true
  end
end

if __FILE__ == $0
  Lox.exec(ARGV)
end
