require 'rubygems'
require 'parslet'

# always use brackets to call methods
# referencing methods without brackets gives you a function pointer.
# lambdas  () -> { body }
# comments #.... <eol>
# 


class CoffeeParser < Parslet::Parser
  root(:doc)
  rule(:doc)  { ( comment | 
                  statement).repeat }

  def till(matcher)
    (matcher.absent? >> any).repeat >> (matcher)
  end

  rule(:comment)        { space? >> str("#") >> till(eol).as(:comment) }
  rule(:statement)      { expression }
  rule(:expression)     { number |
                          string }
  rule(:assignment)     { identifier.as(:left) >> operator.as(:operation) >> identifier.as(:right) }
  ## TOKENS ##

  rule(:space)              { match('[\s\n]').repeat(1) }
  rule(:space?)             { space.maybe }
  rule(:eol)                { match("\n") | eof }
  rule(:eof)                { any.absent? }

  rule(:digit)              { match('[0-9]') }
  rule(:number)             { space? >> (str('-').maybe >> 
                                 (str('0') | (match('[1-9]') >> digit.repeat)) >> 
                                 (str('.') >> digit.repeat).maybe >> 
                                 ((str('e')| str('E')) >> (str('+')|str('-')).maybe >> digit.repeat ).maybe).as(:number) 
                            }

  rule(:hexdigit)           { match('[0-9a-fA-F]') }
  rule(:escaped_character)  { str('\\') >> (match('["\\\\/bfnrt]') | (str('u') >> hexdigit.repeat(4,4))) }
  rule(:string)             { str('"') >> ( escaped_character | str('"').absent? >> any ).repeat.as(:string) >> str('"') }

  #   rule(:comma)              { space? >> str(',') >> space? }
  #   rule(:colon)              { space? >> str(':') >> space? }




#   rule(:value){ 
#     ( string | 
#       identifier |
#       number | 
#       object | 
#       array  | 
#       str('true').as(:true) | 
#       str('false').as(:false) | 
#       str('null').as(:null) 
#     ).as(:val) 
# 	}

#   rule(:entry)              { (string|identifier) >> colon >> expression }
#   rule(:pair_list)          { entry>> (comma >> entry).repeat }
#   rule(:object)             { str('{') >> space? >> pair_list.maybe >> space? >> str('}') }

#   rule(:value_list)         { expression >> (comma >> expression).repeat }
#   rule(:array)              { str('[') >> space? >> value_list.maybe >> space? >> str(']')}

#   rule(:json)               { space? >> value >> space?}

# #####^^^ JSON^^^^#####
#   root(:doc)
#   rule(:doc)            { statement.repeat(1) }


# 	rule(:eol)			      { any.absnt? | comment }
# 	rule(:white_space)    { space | eol }

# 	rule(:verbatum)   		{ start_javascript >> javascript.as(:js) >> end_javascript }
# 	rule(:ifcondition) 		{ t('if') >> t('(') >> expression >> t(')') >> statement }
# 	rule(:statement)  		{ ifcondition | assignment }
# 	rule(:function)   		{ 
#     (t('(') >> parameter_list.maybe  >> t(')') >> t('->') >> expression) |
# 		function_ref
# 	}
# 	rule(:function_ref)		{ class_name >> str('.') >> identifier } 
#   rule(:function_call)  { identifier >> str('(')>> space? >> value_list >> t(')')} 
# 	rule(:parameter_list)	{ identifier >> (comma >> identifier).repeat >> str("...").maybe}
# 	rule(:expression) 		{ 
#     (value >> op('[\+\*\-\/\%\^]') >> expression) |        
#     function_call | 
#     function |
#     value }

# 	rule(:assignment) 		{ identifier.as(:variable) >>  t('=') >> value.as(:val) }
# 	rule(:identifier) 		{ match('[a-z]') >> match('[A-Za-z0-9]').repeat }
#   rule(:class_name)     { match('[A-Z]') >> match('[A-Za-z0-9]').repeat }

# 	def t(text) ;(space? >> str(text) >> space?) ;end
# 	def op(text) ;(space? >> match(text) >> space?) ;end

# 	rule(:start_javascript) 	{str("`")}
# 	rule(:end_javascript) 		{str("`")}
# 	rule(:javascript) 			  {(end_javascript.absnt? >> any).repeat}    
end

