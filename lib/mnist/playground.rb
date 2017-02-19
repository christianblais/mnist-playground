require "logger"
require "mnist/dataset"
require "mnist/strategies/base"
require "mnist/strategies/random"

module Mnist
  class Playground
    attr_accessor :strategies, :logger

    def initialize
      @strategies = Mnist::Strategies::Base.descendants.map(&:new)
      @results = Hash.new { |hash, key| hash[key] = [] }
      @logger = Logger.new(STDOUT)

      log_level(Logger::INFO)
    end

    def log_level(level)
      @logger.level = level
    end

    def train(dataset = Mnist::Dataset::TRAIN_DUMMY)
      with_dataset(dataset) do |value, data|
        strategies.each do |strategy|
          strategy.train(value, data)
        end
      end
    end

    def guess(dataset = Mnist::Dataset::TEST_DUMMY)
      with_dataset(dataset) do |value, data|
        strategies.each do |strategy|
          guess = strategy.guess(data)
          @results[strategy] << { value: value, guess: guess, result: guess == value }
        end
      end
    end

    def results
      @results.map do |strategy, results|
        success, failure = results.partition { |result| result[:result] }
        [strategy.name, { success: success.size, failure: failure.size }]
      end.to_h
    end

    private

    def with_dataset(dataset)
      lines = File.open(dataset).readlines

      logger.debug("Filename: #{dataset}")
      logger.debug("Dataset: #{lines.size} entries")

      lines.each.with_index do |line, index|
        logger.debug("#{((index.to_f + 1) / lines.size * 100).round(2)}%")
        value, *data = line.split(',').map(&:to_i)
        yield(value, data, index)
      end
    end
  end
end
