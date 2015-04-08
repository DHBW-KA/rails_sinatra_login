# Put the files in a path containing 'lib/minitest' will remove them from the backtrace

class MiniTest::Test

  def assert_select selector, text=nil
    matches = html_document.css(selector)
    assert !matches.empty?, "Selector not found #{selector}"
    return if text.nil?
    num = text.is_a?(Fixnum) ? text : 1
    matches.reject do |match|
      match.text == text
    end unless text.is_a?(Fixnum)
    assert matches.size >= num, "Expected to find at least <#{num}> element <#{selector}> #{"with text <#{text}>" unless text.is_a?(Fixnum)} but found <#{matches.size}> in #{response.body}"
  end

  def assert_response code
    assert last_response.send("#{code}?"), "Response should be <#{code}> but was #{response.status}"
  end

  private
    def document_root_element
      html_document.root
    end

    def html_document
      @html_document ||= if response.content_type =~ /xml$/
                           Nokogiri::XML::Document.parse(response.body)
                         else
                           Nokogiri::HTML::Document.parse(response.body)
                         end
    end
end