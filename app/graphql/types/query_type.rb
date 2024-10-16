# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    # TODO: remove me
    field :posts, resolver: Resolvers::Posts
  end
end
