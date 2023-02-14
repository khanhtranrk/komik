# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.3'

gem 'active_model_serializers'
gem 'activerecord-import'
gem 'bcrypt', '~> 3.1.7'
gem 'bootsnap', require: false
gem 'image_processing', '>= 1.2'
gem 'jwt'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'rack-cors'
gem 'rails', '~> 7.0.4'
gem 'rails-i18n'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
gem 'stripe'
gem 'will_paginate', '~> 3.1.0'

group :development, :test do
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'dotenv-rails'
  gem 'rubocop'
  gem 'rubocop-rails'
end

group :development do
  gem 'solargraph'
end
