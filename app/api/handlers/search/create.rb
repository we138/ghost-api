# frozen_string_literal: true

module API
  module Handlers
    module Search
      class Create
        include Import[search: 'github.operations.search']

        Schema = Dry::Schema.Params do
          optional(:query).maybe(:string)
          optional(:name).maybe(:string)
          optional(:language).maybe(:string)

          optional(:page).filled(:integer)
          optional(:per_page).filled(:integer)
        end

        def call(env)
          params = validate_params(env)
          if params.success?
            result = search.call(params.value!.to_h)
            respond_with(result)
          else
            respond_with(params)
          end
        end

        private

        # TODO: move this section to handlers helpers

        def validate_params(env)
          Schema.call(env['router.parsed_body']).to_monad
        end

        def respond_with(result)
          return response(422, result.failure.errors.to_h) if result.failure?

          response(
            200,
            Serializers::Repositories.new(result.value!, with: Serializers::Repository)
          )
        end

        def response(status, body)
          [status, default_headers, [body.to_json]]
        end

        def default_headers
          {
            'Content-Type' => 'application/json'
          }
        end
      end
    end
  end
end
