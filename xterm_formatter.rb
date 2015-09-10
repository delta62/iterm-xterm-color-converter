module ColorParser
  class XtermFormatter
    def format(color)
      name = xterm_name(color)
      return unless name

      "#{format_name(name)}:\t\t#{format_value(color)}"
    end

    private

    def xterm_name(color)
      digit = color.name.match(/\d+/) {|m| m }
      if digit
        "color#{digit}"
      elsif color.name =~ /foreground/i
        'foreground'
      elsif color.name =~ /background/i
        'background'
      else
        false
      end
    end

    def format_name(name)
      "XTerm*#{name}"
    end

    def format_value(color)
      color.to_hex
    end
  end
end
