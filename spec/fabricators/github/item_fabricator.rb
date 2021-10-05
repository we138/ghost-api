# frozen_string_literal: true

Fabricator(:item, from: 'Entities::Search::Item') do
  name 'rom-rb'
  language 'ruby'
  description 'whatever'
  html_url 'whatever'
end
