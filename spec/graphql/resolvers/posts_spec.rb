require 'rails_helper'

RSpec.describe Resolvers::Posts, type: :request do
  let!(:post_1) { create(:post) }
  let!(:post_2) { create(:post) }

  context 'query for post' do
    it 'returns all posts' do
      data, errors = execute(query)
      expect(data.posts.pluck('id')).to match_array([post_1.id.to_s, post_2.id.to_s])
    end
  end

  def query
    <<~GQL
      query { posts { id title description} }
    GQL
  end
end