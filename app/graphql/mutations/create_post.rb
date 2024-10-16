# frozen_string_literal: true

module Mutations
  class CreatePost < Mutations::BaseMutation

    argument :attributes, ::Attributes::CreatePostAttributes, required: true

    type Types::PostType

    def resolve(attributes:)
      Post.create!(attributes.to_h)
    end
  end
end
