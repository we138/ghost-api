# frozen_string_literal: true

class StructsGenerator < Fabrication::Generator::Base
  def self.supports?(klass)
    klass <= Dry::Struct
  end

  def build_instance
    self._instance = _klass.new(_attributes)
  end
end

Fabrication.configure do |config|
  config.generators << StructsGenerator
end
