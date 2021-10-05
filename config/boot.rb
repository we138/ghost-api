# frozen_string_literal: true

ENV['APP_ENV'] ||= 'development'

require 'bundler'
Bundler.require(:default, :development)

begin
  unless ENV['APP_ENV'] == 'production'
    require 'dotenv'
    Dotenv.load('.env', ".env.#{ENV['APP_ENV']}")
  end
rescue LoadError
  nil
end
