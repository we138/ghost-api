# frozen_string_literal: true

require 'dry/system/container'

class Container < Dry::System::Container
  configure do |config|
    config.component_dirs.add 'lib'
  end
end
