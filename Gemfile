source 'https://rubygems.org'

ruby '2.2.2'

gem 'rails', '4.2.1'

gem 'dotenv-rails', groups: [:development, :test]
gem 'sass-rails', '~> 5.0.0'
gem 'uglifier', '>= 1.3'
gem 'coffee-rails', '~> 4.0'
gem 'jquery-rails'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'spring', group: :development
gem 'unicorn'
gem 'pg'
gem 'compass-rails'
gem 'faker'
gem 'bcrypt', '~> 3.1.7'
gem 'cancancan', '~> 1.9'
gem 'rails_admin', '~> 0.6.6'
gem 'sucker_punch', '~> 1.0'
gem 'skylight', group: :production
gem 'paperclip'

group :development, :test do
  gem 'simplecov', require: false, group: :test
  gem 'nokogiri'
  gem 'rspec-rails'
  gem 'better_errors'
  gem 'pry'
  gem 'capybara'
  gem 'selenium'
  gem 'binding_of_caller'
  gem 'launchy'
  gem 'guard-rspec', require: false
  gem 'factory_girl_rails'
  gem 'traceroute'
  gem 'populator'
end

group :production, :staging do
  gem 'rails_12factor'
end
