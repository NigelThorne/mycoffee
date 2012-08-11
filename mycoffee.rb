require 'rubygems'
require 'parslet'

# always use brackets to call methods
# referencing methods without brackets gives you a function pointer.
# lambdas  () -> { body }
# comments #.... <eol>
# 


class CoffeeParser < Parslet::Parser
  rule(:space)              { match('[\s\n]').repeat(1)}
  rule(:space?)             { space.maybe }
  rule(:digit)              { match('[0-9]') }
  rule(:hexdigit)           { match('[0-9a-fA-F]') }
  rule(:comma)              { space? >> str(',') >> space? }
  rule(:colon)              { space? >> str(':') >> space? }

  rule(:escaped_character)  { str('\\') >> (match('["\\\\/bfnrt]') | (str('u') >> hexdigit.repeat(4,4))) }

  rule(:number)             { space? >> str('-').maybe >> 
                                (str('0') | (match('[1-9]') >> digit.repeat)) >> 
                                (str('.') >> digit.repeat).maybe >> 
                                ((str('e')| str('E')) >> (str('+')|str('-')).maybe >> digit.repeat ).maybe 
                            }

  rule(:string){ 
    str('"') >> 
     	(escaped_character | str('"').absent? >> any).repeat.as(:string) >> 
	str('"') 
  }

  rule(:value){ 
     (string | 
      number | 
      object | 
      array  | 
      str('true').as(:true) | 
      str('false').as(:false) | 
      str('null').as(:null)).as(:val) |
      function_call | 
      function_ref |
      function |
      identifier
	}

  rule(:entry)              { (string|identifier) >> colon >> expression }
  rule(:pair_list)          { entry>> (comma >> entry).repeat }
  rule(:object)             { str('{') >> space? >> pair_list.maybe >> space? >> str('}') }

  rule(:value_list)         { value >> (comma >> value).repeat }
  rule(:array)              { str('[') >> space? >> value_list.maybe >> space? >> str(']')}

  rule(:json)               { space? >> value >> space?}

#####^^^ JSON^^^^#####

	rule(:comment)		    { space? >> str("#") >> (match("\n").absent? >> any).repeat >> (match("\n")|any.absnt?)}
	rule(:eol)			      { any.absnt? | comment }
	rule(:white_space)    { space | eol }

	root(:doc)
	rule(:doc)        		{ statement.repeat(1) }
	rule(:verbatum)   		{ start_javascript >> javascript.as(:js) >> end_javascript }
	rule(:if)         		{ statement >> t('if') >> value }
	rule(:statement)  		{ assignment }
	rule(:function)   		{ (t('(') >> parameter_list.maybe  >> t(')') >> t('->') >> expression) |
							  function_ref
							}
	rule(:function_ref)		{ class_name >> str('.') >> identifier} 
  rule(:function_call)  { identifier >> str('(')>> space? >> value_list >> t(')')} 
	rule(:parameter_list)	{ identifier >> (comma >> identifier).repeat >> str("...").maybe}
	rule(:expression) 		{ value >> op('[\+\*\-\/\%\^]') >> expression |  value }

	rule(:assignment) 		{ identifier >>  t('=') >> (value | function) }
	rule(:identifier) 		{ match('[a-z]') >> match('[A-Za-z0-9]').repeat }
  rule(:class_name)     { match('[A-Z]') >> match('[A-Za-z0-9]').repeat }


	def t(text) ;(space? >> str(text) >> space?) ;end
	def op(text) ;(space? >> match(text) >> space?) ;end

	rule(:start_javascript) 	{str("%JS{")}
	rule(:end_javascript) 		{str("}JS%")}
	rule(:javascript) 			  {(end_javascript.absnt? >> any).repeat}    
end

class CoffeeTransformer < Parslet::Transform 
end