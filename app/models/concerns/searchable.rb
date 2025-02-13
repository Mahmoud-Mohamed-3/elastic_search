module Searchable
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks


    settings index: { number_of_shards: 1, number_of_replicas: 0 }

    def self.search(query)
      search_definition = {
        query: {
          multi_match: {
            query: query,
            fuzziness: "AUTO"
          }
        }
      }
      __elasticsearch__.search(search_definition).records
    end
  end
end
