# frozen_string_literal: true

require_relative './serializers/repository'
require_relative './serializers/repositories'

require_relative './handlers/search/create'

module API
  class Application < Hanami::API
    post '/search', to: API::Handlers::Search::Create.new
  end
end
