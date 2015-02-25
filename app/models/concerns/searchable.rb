module Searchable

  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks

    def self.search(query)
      __elasticsearch__.search(
        {
          query: {
            filtered: {
              query: {
                multi_match: {
                  analyzer: 'standard',
                  query: query,
                  fields: [:description, :name, 'keywords.name']
                }
              },
              filter: {
                and: {
                  must: [ term: { status: true } ]
                }
              }
            }
          }
        }
      )
    end

    def as_indexed_json(options={})
      as_json({
        only: [:name, :description, :workflow_state, :status],
        include: {
          keywords: { only: :name },
          category: { only: :status }
        }
      })
    end

  end

end