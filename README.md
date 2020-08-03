# EmbedCallbacks

[![Build Status](https://travis-ci.org/hotoolong/embed_callbacks.svg?branch=main)](https://travis-ci.org/hotoolong/embed_callbacks)

This gem makes it easy to create callbacks.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'simple_callbacker', github: 'hotoolong/embed_callbacks'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install specific_install
    $ gem specific_install git@github.com:hotoolong/embed_callbacks.git main 

## Usage

embed_callback provides the following callbacks.

`before` is called the operation before the specified method.
`after` is called processing after the specified method.
`around` is called processing before and after the specified method.
`rescue` is called if the specified method produces an error.
`ensure` is always called if the given method completes.

### before example

```ruby
require 'embed_callbacks'

class Sample
  include EmbedCallbacks
  set_callback :target, :before, :before_callback

  def target
    puts 'target'
  end

  def before_callback
    puts 'before_callback'
  end

end
sample = Sample.new
sample.target
#=> before_callback
#=> target
```

### after example

```ruby
require 'embed_callbacks'

class Sample
  include EmbedCallbacks
  set_callback :target, :after, :after_callback

  def target
    puts 'target'
  end

  def after_callback
    puts 'after_callback'
  end

end
sample = Sample.new
sample.target
#=> target
#=> after_callback
```

### around example

```ruby
require 'embed_callbacks'

class Sample
  include EmbedCallbacks
  set_callback :target, :around, :around_callback

  def target
    puts 'target'
  end

  def around_callback
    puts 'around_callback'
  end

end
sample = Sample.new
sample.target
#=> around_callback
#=> target
#=> around_callback
```
### rescue example

```ruby
require 'embed_callbacks'

class Sample
  include EmbedCallbacks
  set_callback :target, :rescue, :rescue_callback

  def target
    raise 'target'
  end

  def rescue_callback
    puts 'rescue_callback'
  end

end
sample = Sample.new
sample.target

#=> rescue_callback
#=> RuntimeError (target)
```

### ensure example

```ruby
require 'embed_callbacks'

class Sample
  include EmbedCallbacks
  set_callback :target, :ensure, :ensure_callback

  def target
    puts 'target'
  end

  def ensure_callback
    puts 'ensure_callback'
  end

end
sample = Sample.new
sample.target
#=> target
#=> ensure_callback
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/embed_callbacks. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/embed_callbacks/blob/master/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the EmbedCallbacks project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/embed_callbacks/blob/master/CODE_OF_CONDUCT.md).
