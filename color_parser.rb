require 'nokogiri'
require './iterm_color_doc'
require './color'
require './xterm_formatter'

unless $*.length == 1
  abort "Usage: #{$0} iterm_scheme.itermcolors"
end

begin
  file = open($*[0])
rescue Errno::ENOENT
  abort "Cannot find specified file '#{$*[0]}'."
end

color_parser = ColorParser::ITermColorDoc.new
parser = Nokogiri::XML::SAX::Parser.new(color_parser)
parser.parse file

formatter = ColorParser::XtermFormatter.new
color_parser.colors.each do |color|
  formatted = formatter.format(color)
  puts formatted if formatted
end
