source 'https://rubygems.org'

gem 'rails', '3.2.7'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

# for Heroku deployment - as described in Ap. A of ELLS book

group :test do
  gem 'cucumber-rails', :require => false
  gem 'cucumber-rails-training-wheels'
  gem 'database_cleaner'
end

group :development, :test do
  gem 'sqlite3'
  gem 'ruby-debug19', :require => 'ruby-debug'
  gem 'debugger'
  gem 'capybara'
  gem 'launchy'
  gem 'rspec-rails', '~> 2.4'
  gem 'shoulda-matchers'
  gem 'simplecov'
  gem 'rails3-generators'
  gem 'thin'
  gem 'spork', '0.9.2'
  gem 'factory_girl_rails'

  gem 'debugger'

end

group :production do
  gem 'pg'
  gem 'authlogic'
end

group :development do
  gem 'rails-dev-tweaks', '~> 0.6.1'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do

  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby
  gem 'jquery-ui-rails'
  gem 'jquery-rails'
  gem 'twitter-bootstrap-rails', :git => 'git://github.com/seyhunak/twitter-bootstrap-rails.git', :branch => 'static'
  gem 'uglifier', '>= 1.0.3'
end


gem 'jquery-rails'
gem 'json'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'

# this make rails server super slow
gem 'haml'
gem 'haml-rails'
gem 'wicked'
gem 'dynamic_form'
gem 'simplecov'
gem 'authlogic'
gem 'selenium-webdriver', '2.25.0'
gem 'thin'
