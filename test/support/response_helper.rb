
class MiniTest::Test
  def json
    @json ||= begin
      body = response.body
      body = '{}' if body.nil? || body == ''
      JSON.parse(body)
    end
  end

  cattr_accessor(:session) { {} }

  def response
    last_response
  end

end