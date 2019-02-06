# ActiveRecord::Errors::Localize

Localize & Customize ActiveRecord Error messages to show user.

## Motivation
In default,  [ActiveRecord Errors can not be localized](https://github.com/rails/rails/issues/35147) other than [ActiveRecord::RecordInvalid](https://github.com/rails/rails/blob/master/activerecord/lib/active_record/validations.rb#L22)

```ruby
begin
  User.find(0)
rescue ActiveRecord::RecordNotFound => e
  p(e.message) # => "Couldn't find User with 'id'=0" This message is static and can not change and localize
end
```

Most of cases, it's no problem ActiveRecord Error messages are only english,
but in some cases like error handler below, it needs localization.

```ruby
module ErrorHandler
  extend ActiveSupport::Concern
  included do
    # ... other rescue_from
    rescue_from ActiveRecord::RecordNotFound do |e|
	  # this error message is showed to user, need to localize.
      render json: { error_message: e.message }, status: :not_found
    end
	# ...
  end
end
```

By using this gem, you can use solve this problem in simple way :)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'active_record-errors-localize'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install active_record-errors-localize

## Usage

First, add localization data to i18n localization file.
Add key of {lang}.activerecord.errors.messges.{underscored_error_class_name}

Customize example
```yaml:en.yaml
en:
  activerecord:
    models:
      user: User
    errors:
      messages:
        record_not_found: "Sorry, We can't find your %{model} ID: %{id}  PrimaryKey: %{primary_key}" # => Sorry, We can't find your User ID: 1  PrimaryKey: id
        record_not_saved: "%{record} is not saved reason: %{errors}" # => User is not saved reason: xxxxx
        record_not_destroyed: "%{record} is not deleted reason: %{errors}" # => User is not deleted reason: yyyyy
```

Localize example
```yaml:ja.yaml
ja:
  activerecord:
    models:
      user: ユーザー
    errors:
      messages:
        record_not_found: "%{model}が見つかりません。" #=> ユーザーが見つかりません。
        record_not_saved: "%{record}が保存されませんでした。" #=> ユーザーが保存されませんでした。
        record_not_destroyed: "%{record}が削除されませんでした。" #=> ユーザーが削除されませんでした。
```

Now, you can use #i18n_message method like this.

```ruby
# Need to write using cuz implemented by refinements
using ActiveRecord::Errors::Localize
begin
  User.find(0)
rescue ActiveRecord::RecordNotFound => e
  # Can get localized message by #i18n_message
  p(e.i18n_message) # => "ユーザーが見つかりません。" 
end
```

You can see more practical error handler usage in [this example](https://github.com/kazuooooo/active_record-errors-localize/blob/master/examples/error_handler.rb)

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/active_record-errors-localize. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the ActiveRecord::Errors::Localize project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/active_record-errors-localize/blob/master/CODE_OF_CONDUCT.md).
