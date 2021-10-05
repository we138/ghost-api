Container.boot(:config) do |container|
  container.namespace(:config) do
    namespace(:github) do
      register(:url) { ENV.fetch('GITHUB_API_URL') }
    end
  end
end
