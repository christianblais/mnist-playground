module Mnist
  module Displayers
    class Basic
      def self.common(data1, data2)
        display(data1.zip(data2).map do |(value1, value2)|
          if value1 > 0 && value2 > 0
            (value1 + value2) / 2
          else
            0
          end
        end)
      end

      def self.diff(data1, data2)
        display(data1.zip(data2).map do |(value1, value2)|
          if value1 > 0 && value2 == 0
            value1
          elsif value1 == 0 && value2 > 0
            value2
          else
            0
          end
        end)
      end

      def self.all(data1, data2)
        display(data1.zip(data2).map do |(value1, value2)|
          (value1 - value2).abs
        end)
      end

      def self.display(data, length: Math.sqrt(data.size))
        data.each_slice(length) do |row|
          puts(row.map do |value|
            if value > 225
              '@'
            elsif value > 175
              '0'
            elsif value > 100
              'O'
            elsif value > 0
              'o'
            else
              '-'
            end
          end.join)
        end
      end
    end
  end
end
