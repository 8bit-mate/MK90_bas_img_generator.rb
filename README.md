## Description

Converts a binary image to a list of unformatted MK90 BASIC statements (operator's keywords and arguments).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'MK90_bas_img_generator'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install MK90_bas_img_generator

## Usage

```ruby
require "MK90_bas_img_generator"

gen = MK90BasImgGenerator.new(
  generator: generator,
  binary_image: binary_image
  # put options here
)

gen.generate
```

## Development

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

You can also run `bin/console` for an interactive prompt that will allow you to experiment.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/8bit-mate/MK90_bas_img_generator.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
