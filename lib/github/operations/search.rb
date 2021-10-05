# frozen_string_literal: true

require_relative '../../entities/search'

module Github
  module Operations
    class Search
      include Dry::Monads[:result]
      include Dry::Monads::Do.for(:call)
      include Import[
        api: 'github.provider.api',
        contract: 'github.contracts.search'
      ]

      def call(input)
        input = yield contract.call(input).to_monad

        payload = prepare_payload(**input.to_h.slice(:name, :language, :query))
        result = api.search(payload, page: input[:page], per_page: input[:per_page])
        dto = build_dto(input, result.to_h)

        Success(dto)
      end

      private

      def prepare_payload(query: nil, name: nil, language: nil)
        return query if query
        return "#{name}+language:#{language}" if name && language
        return "language:#{language}" if language
        return name if name
      end

      def build_dto(input, result)
        result
          .merge(page: input[:page], per_page: input[:per_page])
          .then { Entities::Search.new(_1) }
      end
    end
  end
end
