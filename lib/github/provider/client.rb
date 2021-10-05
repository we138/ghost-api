# frozen_string_literal: true

module Github
  module Provider
    class Client
      include Import['config.github.url']

      Error = Class.new(StandardError)

      def get(options = {})
        call(**options.merge(method: :get))
      end

      def call(method:, path:, payload: nil)
        with_error_handling do
          payload = payload&.to_json unless method == :get
          response = connection.public_send(method, path, payload, nil)

          JSON.parse(response.body)
        end
      end

      private

      def with_error_handling
        yield
      rescue Faraday::ClientError => e
        description = e.response.values_at(:status, :body).join(': ') if e.response
        description = [e.message, description].compact.join(' ')

        raise Error, description
      end

      def connection
        @connection ||= Faraday.new(url: url) do |f|
          f.response(:raise_error)
          f.adapter(Faraday.default_adapter)

          f.headers = {
            'Accept': 'application/vnd.github.v3+json'
          }
        end
      end
    end
  end
end
