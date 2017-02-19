module Mnist
  module Dataset
    extend self
    def root
      File.expand_path('../../..', __FILE__)
    end

    def data(file)
      File.join(root, 'data', file)
    end

    TRAIN_DUMMY = data('train_dummy.csv')
    TRAIN = data('train.csv')
    TEST_DUMMY = data('test_dummy.csv')
    TEST = data('test.csv')
  end
end
