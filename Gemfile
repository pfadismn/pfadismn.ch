source 'http://rubygems.org'

gem 'rails', '~> 3.2'

# Authentication & authorisation
gem 'cancan'
gem 'authlogic'

# Data
gem 'mysql2'
gem 'nested_set'
gem 'paperclip'

# Show
gem 'index_helper', git: 'https://github.com/diegosteiner/index_helper.git'
#gem 'index_helper', path: '/home/digi/workspaces/private/Gems/index_helper'
gem 'formtastic'
gem 'dynamic_form'
gem 'kaminari'
gem 'nokogiri'
gem 'RedCloth'
gem 'pdfkit'

# Tools
gem 'rubyzip'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'jquery-rails'
  gem 'jquery-ui-rails'
  gem 'uglifier'
  gem 'therubyracer', platforms: :ruby
end

group :development do
  gem 'mina', git: 'https://github.com/nadarei/mina.git'
end

group :test do
  # Pretty printed test output
  gem 'turn', :require => false
end

group :production do
  gem 'exception_notification'
  gem 'puma'
end
