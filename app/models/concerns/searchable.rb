module Searchable

  extend ActiveSupport::Concern

  included do

    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks

    def location
      "#{ address.latitude }, #{ address.longitude }"
    end

    def self.search(query)
      __elasticsearch__.search(
        {
          query: {
            filtered: {
              query: {
                multi_match: {
                  analyzer: 'standard',
                  query: query,
                  fields: [:description, :name, :keywords ]
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

    def self.search_nearby(category, geolocation, sort_order)
      __elasticsearch__.search(
        {
          query: {
            filtered: {
              query: {
                match_all: {}
              },
              filter: {
                and: {
                  must: [
                    term: {
                      :'category.name' => category.name
                    }
                  ]
                }
              }
            }
          },
          sort: [
            sort_order_hash(geolocation, sort_order)
          ]
        }
      )
    end

    def self.sort_order_hash(geolocation, sort_order)
      if sort_order['average_rating'].present?
        {
          average_rating: {
            order: sort_order['average_rating']
          }
        }
      else
        {
          _geo_distance: {
            location: geolocation,
            order: 'asc',
            unit: :km,
            distance_type: :plane
          }
        }
      end
    end

    def as_indexed_json(options={})
      as_json({
        only: [:name, :description, :workflow_state, :status, :average_rating],
        include: {
          keywords: { only: :name },
          category: { only: [:name, :status] },
          address: { only: [:longitude, :latitude] }
        }
      })
    end

    mapping do
      indexes :location, type: :geo_point
    end

  end

end