source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.4'
# Use mysql as the database for Active Record
gem 'mysql2'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc
# Make serializer to desplay json
gem "active_model_serializers"
# Authentication
gem 'devise'
# Authorization
gem 'cancancan', '~> 1.9'
# keeps configuration out of Git
gem "figaro"

group :development, :test do
	# Using for testing
	gem 'rspec-rails', '~> 3.0.0'
	# Using for create DB ERD
	gem 'railroady' # railroady -M | neato -Tpng > db_erd.png
  end

group :production do
  	gem 'capistrano', '~> 3.1.0'
  	gem 'capistrano-bundler', '~> 1.1.2'
  	gem 'capistrano-rails', '~> 1.1.1'
  	gem 'capistrano-rvm', github: "capistrano/rvm"
  end

# Specify ruby version
ruby '2.1.2'