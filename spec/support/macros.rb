
def execute(query, variables: {}, key: nil)
  post '/graphql', params: { query:, variables: }

  response_body = RecursiveOpenStruct.new(JSON.parse(response.body))
  if response.status == 200
    [
      key ? response_body.dig(:data, key) : response_body.data,
      response_body.errors
    ]
  else
    [ response_body.dig(:data), response_body.dig(:errors) ]
  end
end

def query_string(params)
  return if params.blank?

  array = reduce_params(params)
  array.try { |item| "(#{item.join(',')})" }
end

def reduce_params(params)
  params.reduce([]) do |arr, param|
    key, value = param
    formatted = if value.is_a?(String)
                  "\"#{value}\""
    else
                  value.is_a?(Hash) ? "{#{query_string(value).delete('()')}}" : value
    end
    arr << "#{key.to_s.camelize(:lower)}:#{formatted}"
  end
end
