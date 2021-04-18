# frozen_string_literal: true
source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.8'

gem 'active_model_attributes'
gem 'active_model_serializers', '~> 0.10'
gem 'activerecord-import', '~> 1.0'
gem 'bcrypt', '~> 3.1'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'cancancan', '~> 3.1'
gem 'dotenv-rails'
gem 'jwt', '~> 2.2'
gem 'niceql', '~> 0.1.25'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 4.1'
gem 'rack-cors', '~> 1.1'
gem 'rails', '~> 6.0.3', '>= 6.0.3.6'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'database_cleaner', '~> 1.8'
  gem 'debase'
  gem 'factory_bot_rails', '~> 5.2'
  gem 'rspec', '~> 3.9'
  gem 'rspec-rails', '~> 4.0'
  gem 'rubocop', '~> 0.92.0'
  gem 'rubocop-rails', '~> 2.8'
  gem 'rubocop-rspec', '~> 1.43'
  gem 'ruby-debug-ide'
  gem 'shoulda-matchers', '~> 4.4'
end

group :development do
  gem 'letter_opener', '~> 1.7'
  gem 'letter_opener_web', '~> 1.4'
  gem 'listen', '~> 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
