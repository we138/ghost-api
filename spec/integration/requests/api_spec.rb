# frozen_string_literal: true

RSpec.describe 'Api:' do
  let(:app) { Ghost.new }

  def build_request(method, path, payload)
    {
      'PATH_INFO' => path,
      'REQUEST_METHOD' => method,
      'rack.input' => StringIO.new(payload),
      'CONTENT_TYPE' => 'application/json'
    }
  end

  describe 'POST /api/search' do
    context 'valid params', vcr: { cassette_name: 'github/search' } do
      let(:body) do
        {
          name: 'rom-rb',
          page: 1,
          per_page: 30
        }
      end

      it 'returns 200' do
        request = build_request('POST', '/api/search', body.to_json)
        response = app.call(request)

        expect(response[0]).to eq 200
      end
    end

    context 'invalid params' do
      let(:body) do
        {
          name: 'smth',
          page: 'foobar',
          per_page: 30
        }
      end

      it 'returns 200' do
        request = build_request('POST', '/api/search', body.to_json)
        response = app.call(request)

        expect(response[0]).to eq 422
      end
    end
  end
end
