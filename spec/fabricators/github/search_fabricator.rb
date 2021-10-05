# frozen_string_literal: true

Fabricator(:github_search, from: 'Entities::Search') do
  total_count 1
  page 1
  per_page 30

  items(count: 1) do
    Fabricate(:item)
  end
end
