# frozen_string_literal: true

require 'representable/coercion'

module Serializers
  class Repository < Representable::Decorator
    include Representable::JSON
    include Representable::Coercion

    property :name, type: Types::String
    property :description, type: Types::Nil | Types::String
    property :language, type: Types::Nil | Types::String
    property :html_url, type: Types::String
  end
end
