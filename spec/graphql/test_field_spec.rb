
require 'rails_helper'

RSpec.describe 'Test Field', type: :request do
  it 'queries test field mutation' do
    query = <<~QUERY
      query { testField }
    QUERY

    data, errors = execute(query)
  end
end