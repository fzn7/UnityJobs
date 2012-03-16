source 'http://rubygems.org'

gem 'rails', '~> 3.1.3'
gem 'jquery-rails'
gem 'sqlite3', '~> 1.3.4'
gem 'kaminari', '~> 0.12.4'
gem 'redcarpet', '~> 2.0.0b5'
gem 'capistrano'

group :staging, :production do
  gem 'postmark-rails', '~> 0.4.1'
  gem 'exception_notification', '~> 2.5.2'
  gem 'mysql2', '~> 0.3.1'
  gem 'unicorn'
  gem 'therubyracer'
end

group :development do
  gem 'letter_opener', '~> 0.0.2'
end

group :development, :test do
  gem 'rspec-rails', '~> 2.7.0'
end

group :assets do
  gem 'uglifier'
end