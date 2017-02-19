# Mnist::Playground

This gem provides a small playground to test different algorithms on the well-known MNIST dataset.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mnist-playground'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mnist-playground

## Usage

#### Basics

By default, `Mnist::Playground` comes with a "random" strategy. To test it out, simply create a new file with the following content;

```ruby
require "mnist/playground"

playground = Mnist::Playground.new
playground.train
playground.guess
puts playground.results
```

Then test it out from the command line. Output should looks like this;

```
$ bundle exec ruby main.rb
{
  "Mnist::Strategies::Random" => { success: 2, failure: 8 }
}
```

That's it. Up to you now to try and build a strategy that do better than random.

#### Custom Strategies

Building a strategy is relative easy; simply define a `train` and a `guess` method, which both act on a given dataset.

```ruby
module Mnist
  module Strategies
    class Random < Base
      def initialize
        @values = []
      end

      # Train strategy to recognize said value based on given
      # dataset. Does not return anything.
      #
      # `value` expected value based on provided data
      # `data` dataset relatives to expected value
      def train(value, data)
        @values << value unless @values.include?(value)
      end

      # Ask strategy to guess expected value based on given
      # data. Return said guess.
      #
      # `data` dataset used to guess value
      def guess(data)
        @values.sample
      end
    end
  end
end
```

#### Datasets

MNIST is a huge collection of handwritten digits following a standardized format. Images have been centered and normalized.
Every pixel is represented by a numerical value ranging from 0 to 255, 0 being white, 255 being black. `Mnist::Playground`
uses a standard CSV format based on the official datasets. The first column represents the digit, whereas the others represents
a linear representation of the pixels. Every row in those files represents a new digit.

`Mnist::Playground` comes with four pre-built datasets, but will work on anything following the above format.

```ruby
# extensive dataset of ~25,000 entries, for extensive training
Mnist::Dataset::TRAIN

# minimalist dataset of ~10 entries, for quick training
Mnist::Dataset::TRAIN_DUMMY

# extensive dataset of ~10,000 entries, for extensive testing
Mnist::Dataset::TEST

# minimalist dataset of ~10 entries, for quick testing
Mnist::Dataset::TEST_DUMMY
```

#### Configuration

`Mnist::Playground` comes with few configuration options.

```ruby
# set custom log level
playground.log_level(Logger::INFO)

# train strategies on a custom dataset
playground.train(File.read('foo.csv'))

# test strategies on a custom dataset
playground.guess(File.read('bar.csv'))
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Christian Blais/mnist-playground. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

