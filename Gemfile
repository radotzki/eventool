source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.4'
# Use postgresql as the database for Active Record
gem 'pg', '~> 0.17.1'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc
# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
gem 'spring',        group: :development

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

gem 'bcrypt', '~> 3.1.7'

# Make serializer to desplay json
gem "active_model_serializers"
# Authentication
gem 'devise'
# Authorization
gem 'cancancan', '~> 1.9'

group :development, :test do
	# Using for testing
  	gem 'rspec-rails', '~> 3.0.0'
  	# Using for create DB ERD
  	gem 'railroady' # railroady -M | neato -Tpng > db_erd.png
end

group :production do
	# Using for Heroku
	gem 'rails_12factor'
end

ruby '2.1.2'