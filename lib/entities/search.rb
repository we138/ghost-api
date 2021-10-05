# frozen_string_literal: true

require 'types'

module Entities
  class Search < Dry::Struct
    transform_keys(&:to_sym)

    attribute :total_count, Types::Integer
    attribute :page, Types::Integer
    attribute :per_page, Types::Integer

    attribute :items, Types::Array do
      attribute :name, Types::String
      attribute :language, Types::Nil | Types::String
      attribute :description, Types::Nil | Types::String
      attribute :html_url, Types::String
    end
  end
end
