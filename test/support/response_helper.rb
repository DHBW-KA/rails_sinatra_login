
class MiniTest::Test
  def json
    @json ||= begin
      body = response.body
      body = '{}' if body.nil? || body == ''
      JSON.parse(body)
    end
  end

  def response
    last_response
  end
end