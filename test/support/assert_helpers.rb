class MiniTest::Test

  def assert_select selector, text=nil
    root = Nokogiri::XML::NodeSet.new html_document
    matches = root.css(selector)
    assert !(matches.empty? || text.nil?), "Selector not found #{selector}"
    matches.reject do |match|
      match.text == text
    end
    assert matches.size >= 1
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