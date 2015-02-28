source 'http://rubygems.org'

ruby '2.2.0'
gem 'rails', '~> 4.2.0'

# Authentication & authorisation
gem 'cancan'
gem 'authlogic'

gem 'mysql2'
gem 'awesome_nested_set'
gem 'paperclip'
gem 'delayed_job_active_record'
gem 'figaro'
gem 'index_helper', git: 'https://github.com/diegosteiner/index_helper.git'
#gem 'index_helper', path: '/home/digi/workspaces/private/Gems/index_helper'
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

#legacy
gem 'actionpack-action_caching'

group :development do
  gem 'mina', git: 'https://github.com/nadarei/mina.git'
  gem 'quiet_assets'
  gem 'web-console', '~> 2.0'
end

group :test do
  # Pretty printed test output
  gem 'turn', :require => false
end

group :production do
  gem 'exception_notification'
  gem 'puma'
end
