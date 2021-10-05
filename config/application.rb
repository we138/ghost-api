# frozen_string_literal: true

require 'hanami/middleware/body_parser'
require 'dry/monads/do'

require_relative './boot'
require_relative '../system/container'
require_relative '../system/import'
require_relative '../app/api/application'

Dry::Validation.load_extensions(:monads)
Dry::Schema.load_extensions(:monads)

Container.finalize!

class Ghost < Hanami::API
  use Hanami::Middleware::BodyParser, :json
  use Rack::Cors do
    allow do
      origins '*'
      resource '*', headers: :any, methods: %i[post]
    end
  end

  mount API::Application.new, at: '/api'
end
