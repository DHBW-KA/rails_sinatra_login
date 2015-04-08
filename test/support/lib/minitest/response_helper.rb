# Put the files in a path containing 'lib/minitest' will remove them from the backtrace

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

  def session
    last_request.env['rack.session']
  end

end