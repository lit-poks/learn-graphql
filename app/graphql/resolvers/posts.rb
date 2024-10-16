# frozen_string_literal: true

module Resolvers
  class Posts < BaseResolver

    type [Types::PostType], null: true

    def resolve(**args)
      Post.all
    end
  end
end
