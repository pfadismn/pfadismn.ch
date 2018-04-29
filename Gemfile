source 'https://rubygems.org'

ruby File.read('.ruby-version').strip
gem 'rails', '~> 5.1.5'

# Authentication & authorisation
gem 'cancancan'
gem 'authlogic', '~> 3.6'

gem 'mysql2'
gem 'rails-i18n', '~> 5.1'
gem 'pg'
gem 'awesome_nested_set'
gem 'paperclip', '~> 5.2.0'
gem 'delayed_job_active_record'
gem 'figaro'
gem 'daemons'
gem 'index_helper', git: 'https://github.com/diegosteiner/index_helper.git'
gem 'formtastic'
gem 'dynamic_form'
gem 'kaminari'
gem 'nokogiri'
gem 'RedCloth'
gem 'pdfkit'
gem 'wkhtmltopdf-heroku'
gem 'rubyzip'
gem 'slim-rails'
gem 'bootstrap-sass', '~> 3.3.6'
gem 'sass-rails', '>= 3.2'
gem 'coffee-rails'
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'uglifier'
gem 'exception_notification'
gem 'rails_12factor'
gem 'pry-rails'

group :development do
  gem 'spring'
  gem 'letter_opener'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'listen'
end

group :test do
  gem 'turn', require: false
  gem 'rspec-rails'
end

group :production do
  gem 'lograge'
  gem 'puma'
end
