source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.2"
gem "rails", "~> 7.0.4"
gem "sprockets-rails"

#gem 'sass-rails'

gem "puma", "~> 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"
gem "tzinfo-data" #, platforms: %i[ mingw mswin x64_mingw jruby ]
gem "bootsnap", require: false

#gem 'wicked_pdf'
gem "ransack", "~> 3.2"
gem 'cloudinary'

gem "devise", "~> 4.8"

gem "rqrcode", "~> 2.1"

gem "chunky_png", "~> 1.4"

gem "barby", "~> 0.6.8"

gem "simple_calendar", "~> 2.4"

#gem 'sassc', '~> 2.2'


gem "letter_opener", group: :development

gem 'wicked_pdf'
gem "wkhtmltopdf-binary", group: :development
gem "wkhtmltopdf-heroku", group: :production

gem 'chartjs-ror', '~> 2.2'

group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
end

group :development do
  gem "web-console"
  gem "sqlite3", "~> 1.4"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
end

group :production do
  gem 'pg', '~> 1.4', '>= 1.4.1'
end

gem "pagy", "~> 5.10"
