# frozen_string_literal: true

module Github
  module Contracts
    class Search < Dry::Validation::Contract
      params do
        optional(:query).maybe(:string)
        optional(:name).maybe(:string)
        optional(:language).maybe(:string)

        optional(:page).filled(:integer, gteq?: 1, lteq?: 1000)
        optional(:per_page).filled(:integer, gteq?: 1, lteq?: 100)
      end

      rule(:query) do
        next if values[:query].nil?

        key.failure('allowed if name and language are empty') if values[:name] && values[:language]
      end

      rule(:name) do
        next if values[:name].nil?

        key.failure('allowed if query are empty') unless values[:query].nil?
      end

      rule(:language) do
        next if values[:language].nil?

        key.failure('allowed if query are empty') unless values[:query].nil?
      end
    end
  end
end
