require 'rubygems'
require 'parslet'

class JsTransform < Parslet::Transform
    rule(:comment => simple(:comment))           		{ "//#{comment}"   }
    rule(:js => simple(:inline))           				{ inline   }
    rule(:number => simple(:number))             		{ number }
    rule(:string => simple(:string))             		{ "\"#{string}\"" }
end

