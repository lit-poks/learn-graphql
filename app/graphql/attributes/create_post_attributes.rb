# frozen_string_literal: true

module Attributes
  class CreatePostAttributes < Types::BaseInputObject

    argument :title, String, required: true
    argument :description, String, required: true
  end
end
