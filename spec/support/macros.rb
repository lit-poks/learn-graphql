
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

def login(user)
  allow_any_instance_of(Helpers::RecaptchaVerificationHelper) # rubocop:disable RSpec/AnyInstance
    .to receive(:run_recaptcha_verification).and_return(true)
  execute(login_query({ email: user.email, password: user.password }))
end

def login_query(args = {})
  recaptcha_attributes = <<-RECAPTCHA_ATTRIBUTES
      recaptchaAttributes: { token: "#{args[:recaptcha_token]}" }
  RECAPTCHA_ATTRIBUTES

  remember_me_attributes = <<-REMEMBERE_ME_ATTRIBUTES
    rememberMe: #{args[:remember_me]}
  REMEMBERE_ME_ATTRIBUTES


  <<-GRAPHQL
        mutation {
          userLogIn(
            input: {
              attributes: {
                email: "#{args[:email]}"
                password: "#{args[:password]}"
                #{recaptcha_attributes if args[:recaptcha_token]}
                #{remember_me_attributes if args[:remember_me]}
              }
            }
          ) {
            ... on User { email }
            ... on Error { messages }
          }
        }
  GRAPHQL
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
