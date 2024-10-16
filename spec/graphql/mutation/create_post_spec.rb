
require 'rails_helper'

RSpec.describe Mutations::CreatePost, type: :request do
  let!(:params) do
    {
      title: Faker::Book.title,
      description: Faker::Hipster.paragraph
    }
  end

  let!(:params_for_fragmented) do
    {
      input: {
        attributes: {
          title: Faker::Book.title,
          description: Faker::Hipster.paragraph
        }
      }
    }
  end

  context 'with valid params' do
    it 'creates a new post with unfragmented query' do
      data, errors = execute(query(params))
      expect(errors).to be_nil
      expect(data.createPost.title).to eq(params[:title])
      expect(data.createPost.description).to eq(params[:description])
    end

    it 'creates a new post with fragmented query' do
      data, errors = execute(fragment_query, variables: params_for_fragmented.to_json)
      expect(errors).to be_nil
      expect(data.createPost.title).to eq(params_for_fragmented[:input][:attributes][:title])
      expect(data.createPost.description).to eq(params_for_fragmented[:input][:attributes][:description])
    end
  end

  def query(params)
    <<~GQL
        mutation {
         createPost(
          input: { attributes: { title: "#{params[:title]}", description: "#{params[:description]}" }}
         ) {
          title description
        }
      }
    GQL
  end

  def fragment_query
    <<~GQL
      mutation createPost($input: CreatePostInput!) {
        createPost(input: $input) {
          title description
        }
      }
    GQL
  end
end