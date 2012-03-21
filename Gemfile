source 'https://rubygems.org'

# Last updated version of rails
gem 'rails', '3.2.2'

# Back-end stuff
gem 'inherited_resources'
gem 'cancan'

# Front-end stuff
gem 'slim'
gem 'simple_form'
gem 'jquery-rails'
gem 'jasmine'

# Database stuff
gem 'pg'
gem 'foreigner'

# Staging stuff
group :development, :production do
  gem 'heroku'
  gem 'thin'
end

group :test do
  gem 'rspec-rails'
  gem 'cucumber-rails'
  gem 'shoulda-matchers'
  gem 'capybara'
  gem "database_cleaner"
  gem 'factory_girl_rails'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'compass-rails'
  gem 'compass-960-plugin' # <=
  gem "compass-columnal-plugin"

  # When the splash page isn't necessary, remove the line

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer'

  gem 'uglifier', '>= 1.0.3'
end

gem 'omniauth'
gem 'omniauth-oauth2'
gem 'omniauth-facebook'
gem 'taps'
