require "nokogiri"

module ColorParser
  class ITermColorDoc < Nokogiri::XML::SAX::Document

    attr_accessor :colors

    def initialize
      @colors = [ ]
      @context = [ ]
      @current_color = nil
      @current_component = ""
    end

    private

    def start_element(name, attributes = [])
      @context.push name
    end

    def characters(chars)
      chars.strip!
      return if chars.length == 0

      if @context == [ "plist", "dict", "key" ]
        @current_color = Color.new
        @current_color.name = chars
      elsif @context == [ "plist", "dict", "dict", "key" ]
        @current_component = chars.split(" ")[0].downcase
      elsif @context == [ "plist", "dict", "dict", "real" ]
        set_color(chars)
      end
    end

    def end_element(name)
      @colors.push(@current_color) if name == "dict"
      @context.pop
    end

    def set_color(value)
      if @current_component == "red"
        @current_color.red = value
      elsif @current_component == "green"
        @current_color.green = value
      elsif @current_component == "blue"
        @current_color.blue = value
      else
        raise "Unrecognized color '#{@current_component}'"
      end
    end
  end
end
