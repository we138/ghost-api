# frozen_string_literal: true

module Serializers
  class Repositories < Representable::Decorator
    include Representable::JSON
    include Representable::Coercion

    property :data, exec_context: :decorator
    property :meta, exec_context: :decorator

    def initialize(result, with:)
      @with = with

      super(result)
    end

    def data
      @with.for_collection.new(represented.items).to_hash
    end

    def meta
      {
        total: represented.total_count,
        page: normalize_page(represented.page),
        per_page: represented.per_page
      }
    end

    # TODO: move it another class

    def normalize_page(page)
      [page || 1, 1].max
    end
  end
end
