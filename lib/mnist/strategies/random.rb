module Mnist
  module Strategies
    class Random < Base
      def initialize
        @values = []
      end

      def train(value, data)
        @values << value unless @values.include?(value)
      end

      def guess(data)
        @values.sample
      end
    end
  end
end
