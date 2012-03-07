source 'https://rubygems.org'

# Last updated version of rails
gem 'rails', '3.2.2'

# Back-end stuff
gem 'inherited_resources'

# Front-end stuff
gem 'sass-rails', '~> 3.2.3'
gem 'haml'
gem 'simple_form'
gem 'jquery-rails'

# Database stuff
gem 'pg'
gem 'foreigner'

# Stagging stuff
group :development, :production do
  gem 'heroku'
  gem 'thin'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'cucumber-rails'
  gem 'shoulda-matchers'
  gem 'capybara'
  gem "database_cleaner"
  gem 'factory_girl'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'coffee-rails', '~> 3.2.1'
  gem 'compass-rails'
  gem "compass-columnal-plugin"

  # When the splash page isn't necessary, remove the line
    gem 'compass-960-plugin' # <=

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer'

  gem 'uglifier', '>= 1.0.3'
end

