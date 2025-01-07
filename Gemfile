# frozen_string_literal: true

source "https://rubygems.org"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.2.1"
# Use postgresql as the database for Active Record
gem "pg", "~> 1.1"
# Use the Puma web server [https://github.com/puma/puma]
gem "puma", ">= 5.0"
# Build JSON APIs with ease [https://github.com/rails/jbuilder]
# gem "jbuilder"

# Use Redis adapter to run Action Cable in production
gem "redis", ">= 4.0.1"

# Simple, efficient background processing for Ruby. [https://github.com/sidekiq/sidekiq]
gem "sidekiq", "~> 7.3"

# Sidekiq-Cron runs a thread alongside Sidekiq workers to schedule jobs at specified times. [https://github.com/sidekiq-cron/sidekiq-cron]
gem "sidekiq-cron", "~> 2.0"

# The CORS spec allows web applications to make cross domain [https://github.com/cyu/rack-cors]
gem "rack-cors", "~> 2.0"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: [:windows, :jruby]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin Ajax possible
# gem "rack-cors"

group :development, :test do
  # Pry is a runtime developer console and IRB alternative with powerful introspection capabilities. [https://github.com/pry/pry]
  gem "pry", "~> 0.15.0"

  # A terminal spinner for tasks that have non-deterministic time frame [https://github.com/piotrmurach/tty-spinner]
  gem "tty-spinner", "~> 0.9.3"

  # It's a library for generating fake data such as names, addresses, and phone numbers [https://github.com/faker-ruby/faker]
  gem "faker", "~> 3.5"

  # Static analysis for security vulnerabilities [https://brakemanscanner.org/]
  gem "brakeman", require: false
end

group :test do
  # rspec-rails brings the RSpec testing framework to Ruby on Rails [https://github.com/rspec/rspec-rails]
  gem "rspec-rails", "~> 7.1"

  # factory_bot is a fixtures replacement [https://github.com/thoughtbot/factory_bot_rails]
  gem "factory_bot_rails", "~> 6.4"

  # Database Cleaner is a set of gems containing strategies for cleaning your database in Ruby. [https://github.com/DatabaseCleaner/database_cleaner]
  gem "database_cleaner-active_record", "~> 2.2"

  # Shoulda Matchers provides RSpec- and Minitest-compatible one-liners to test common Rails functionality [https://github.com/thoughtbot/shoulda-matchers]
  gem "shoulda-matchers", "~> 6.4"
end

group :development do
  # rubocop kit
  gem "rubocop", "~> 1.69"
  gem "rubocop-performance", "~> 1.23"
  gem "rubocop-rails", "~> 2.27"
  gem "rubocop-shopify", "~> 2.15"
  gem "rubocop-rspec", "~> 3.3"

  # The Ruby LSP is an implementation of the language server protocol for Ruby [https://github.com/Shopify/ruby-lsp]
  gem "ruby-lsp", "~> 0.23.1"
end
