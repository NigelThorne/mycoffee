

class MyJSParser < Parslet::Parser
	root(:doc)

	rule(:doc)       { statement.repeat(1) }
	rule(:statement) { verbatum | _loop.as(:loop) }
	rule(:_loop)     { int.as(:times) >> str(".times") >> lambda }
	rule(:lambda)    { param_def >> str("=>") >> block.as(:body) }
	rule(:param_def) { str('(') >> str(')') }
	rule(:block)	 { str('{') >>  verbatum  >> str('}') }
	rule(:verbatum)  { start_javascript >> javascript.as(:js) >> end_javascript }
	rule(:int)       { match('[0-9]').repeat(1).as(:int) }

	rule(:start_javascript) 	{str("`")}
	rule(:end_javascript) 		{str("`")}
	rule(:javascript) 			{(end_javascript.absnt? >> any).repeat}    
end


