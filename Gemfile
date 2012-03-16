source 'http://rubygems.org'

gem 'rails', '~> 3.1.3'
gem 'jquery-rails'
gem 'sqlite3', '~> 1.3.4'
gem 'mysql2', '< 0.3'
gem 'kaminari', '~> 0.12.4'
gem 'redcarpet', '~> 2.0.0b5'
gem 'unicorn'
gem 'capistrano'
gem 'therubyracer'

group :staging, :production do
  gem 'postmark-rails', '~> 0.4.1'
  gem 'exception_notification', '~> 2.5.2'
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