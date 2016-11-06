source 'https://rubygems.org'

ruby File.read('.ruby-version').strip
gem 'rails', '~> 4.2.0'

# Authentication & authorisation
gem 'cancan'
gem 'authlogic'

gem 'mysql2'
gem 'pg'
gem 'awesome_nested_set'
gem 'paperclip'
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
gem 'rubyzip'
gem 'slim-rails'
gem 'sass-rails'
gem 'coffee-rails'
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'uglifier'
gem 'exception_notification'
gem 'rails_12factor'

#legacy
gem 'actionpack-action_caching'

group :development do
  gem 'quiet_assets'
  gem 'spring'
  gem 'letter_opener'
  gem 'better_errors'
  gem 'binding_of_caller'
end

group :test do
  gem 'turn', require: false
  gem 'rspec-rails'
end

group :production do
  gem 'puma'
  gem 'foreman'
end
