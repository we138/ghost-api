# frozen_string_literal: true

module Github
  module Provider
    class API
      include Import['github.provider.client']

      def search(payload, page: nil, per_page: nil)
        client.get(
          path: 'search/repositories',
          payload: { q: payload, page: page, per_page: per_page }
        )
      end
    end
  end
end
