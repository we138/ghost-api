# frozen_string_literal: true

RSpec.describe Github::Operations::Search do
  subject(:operation) { described_class.new(api: api, contract: contract) }

  let(:api) { instance_double(Github::Provider::API) }
  let(:contract) { instance_double(Github::Contracts::Search) }

  describe '#call' do
    context 'valid input' do
      let(:input) do
        {
          name: 'rom-rb',
          page: 1,
          per_page: 10
        }
      end

      let(:search) do
        {
          'total_count' => 1,
          'page' => 1,
          'per_page' => 50,
          'items' => [
            {
              'name' => 'rom-rb',
              'language' => 'ruby',
              'description' => 'whatever',
              'html_url' => 'path'
            }
          ]
        }
      end

      before do
        allow(contract).to receive(:call).and_return(Success(input))
        allow(api).to receive(:search).and_return(search)
      end

      it 'returns Success()' do
        result = operation.call(input)

        expect(result).to be_success
      end
    end
  end
end
