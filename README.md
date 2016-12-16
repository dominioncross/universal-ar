# UniversalAr
Short description and motivation.

## Usage
How to use my plugin.

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'universal_ar'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install universal_ar
```
```bash
$ rails g universal_ar:install
$ rails g devise:controllers users
$ rails g devise:views users
$ rails db:migrate
$ rails g controller home index
```

Inherit Application controller from UniversalAr::ApplicationController
```bash
$ class ApplicationController < UniversalAr::ApplicationController
```

Add mount the engine in routes.rb
```bash
mount UniversalAr::Engine => '/universal'
```
## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
