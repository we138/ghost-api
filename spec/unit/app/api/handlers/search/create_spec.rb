# frozen_string_literal: true

RSpec.describe API::Handlers::Search::Create do
  subject(:handler) { described_class.new(search: search) }

  let(:search) { instance_double(Github::Operations::Search) }
  let(:search_result) { Fabricate(:github_search) }

  describe '#call' do
    context '' do
      let(:env) do
        build_request(name: 'rom-rb')
      end

      before do
        allow(search)
          .to receive(:call).and_return(Success(search_result))
      end

      it 'returns ok' do
        result = handler.call(env)

        expect(result[0]).to be 200
      end
    end
  end

  def build_request(payload)
    {
      'rack.input' => StringIO.new(payload.to_json),
      'CONTENT_TYPE' => 'application/json'
    }
  end
end
