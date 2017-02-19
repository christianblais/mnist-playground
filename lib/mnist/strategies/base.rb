module Mnist
  module Strategies
    class Base
      def self.descendants
        ObjectSpace.each_object(singleton_class).with_object([]) do |klass, descendants|
          descendants.unshift(klass) unless klass == self
        end
      end

      def name
        self.class.name
      end

      def train(value, data)
        raise NotImplementedError
      end

      def data(data)
        raise NotImplementedError
      end
    end
  end
end
