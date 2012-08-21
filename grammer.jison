{
	"Root": [
		["", "return $$ = new yy.Block;", null],
		["Body", "return $$ = $1;", null],
		["Block TERMINATOR", "return $$ = $1;", null]
	],
	"Body": [
		["Line", "$$ = yy.Block.wrap([$1]);", null],
		["Body TERMINATOR Line", "$$ = $1.push($3);", null],
		["Body TERMINATOR", "$$ = $1;", null]
	],
	"Line": [
		["Expression", "$$ = $1;", null],
		["Statement", "$$ = $1;", null]
	],
	"Statement": [
		["Return", "$$ = $1;", null],
		["Comment", "$$ = $1;", null],
		["STATEMENT", "$$ = new yy.Literal($1);", null]
	],
	"Expression": [
		["Value", "$$ = $1;", null],
		["Invocation", "$$ = $1;", null],
		["Code", "$$ = $1;", null],
		["Operation", "$$ = $1;", null],
		["Assign", "$$ = $1;", null],
		["If", "$$ = $1;", null],
		["Try", "$$ = $1;", null],
		["While", "$$ = $1;", null],
		["For", "$$ = $1;", null],
		["Switch", "$$ = $1;", null],
		["Class", "$$ = $1;", null],
		["Throw", "$$ = $1;", null]
	],
	"Block": [
		["INDENT OUTDENT", "$$ = new yy.Block;", null],
		["INDENT Body OUTDENT", "$$ = $2;", null]
	],
	"Identifier": [
		["IDENTIFIER", "$$ = new yy.Literal($1);", null]
	],
	"AlphaNumeric": [
		["NUMBER", "$$ = new yy.Literal($1);", null],
		["STRING", "$$ = new yy.Literal($1);", null]
	],
	"Literal": [
		["AlphaNumeric", "$$ = $1;", null],
		["JS", "$$ = new yy.Literal($1);", null],
		["REGEX", "$$ = new yy.Literal($1);", null],
		["DEBUGGER", "$$ = new yy.Literal($1);", null],
		["UNDEFINED", "$$ = new yy.Undefined;", null],
		["NULL", "$$ = new yy.Null;", null],
		["BOOL", "$$ = new yy.Bool($1);", null]
	],
	"Assign": [
		["Assignable = Expression", "$$ = new yy.Assign($1, $3);", null],
		["Assignable = TERMINATOR Expression", "$$ = new yy.Assign($1, $4);", null],
		["Assignable = INDENT Expression OUTDENT", "$$ = new yy.Assign($1, $4);", null]
	],
	"AssignObj": [
		["ObjAssignable", "$$ = new yy.Value($1);", null],
		["ObjAssignable : Expression", "$$ = new yy.Assign(new yy.Value($1), $3, 'object');", null],
		["ObjAssignable : INDENT Expression OUTDENT", "$$ = new yy.Assign(new yy.Value($1), $4, 'object');", null],
		["Comment", "$$ = $1;", null]
	],
	"ObjAssignable": [
		["Identifier", "$$ = $1;", null],
		["AlphaNumeric", "$$ = $1;", null],
		["ThisProperty", "$$ = $1;", null]
	],
	"Return": [
		["RETURN Expression", "$$ = new yy.Return($2);", null],
		["RETURN", "$$ = new yy.Return;", null]
	],
	"Comment": [
		["HERECOMMENT", "$$ = new yy.Comment($1);", null]
	],
	"Code": [
		["PARAM_START ParamList PARAM_END FuncGlyph Block", "$$ = new yy.Code($2, $5, $4);", null],
		["FuncGlyph Block", "$$ = new yy.Code([], $2, $1);", null]
	],
	"FuncGlyph": [
		["->", "$$ = 'func';", null],
		["=>", "$$ = 'boundfunc';", null]
	],
	"OptComma": [
		["", "$$ = $1;", null],
		[",", "$$ = $1;", null]
	],
	"ParamList": [
		["", "$$ = [];", null],
		["Param", "$$ = [$1];", null],
		["ParamList , Param", "$$ = $1.concat($3);", null],
		["ParamList OptComma TERMINATOR Param", "$$ = $1.concat($4);", null],
		["ParamList OptComma INDENT ParamList OptComma OUTDENT", "$$ = $1.concat($4);", null]
	],
	"Param": [
		["ParamVar", "$$ = new yy.Param($1);", null],
		["ParamVar ...", "$$ = new yy.Param($1, null, true);", null],
		["ParamVar = Expression", "$$ = new yy.Param($1, $3);", null]
	],
	"ParamVar": [
		["Identifier", "$$ = $1;", null],
		["ThisProperty", "$$ = $1;", null],
		["Array", "$$ = $1;", null],
		["Object", "$$ = $1;", null]
	],
	"Splat": [
		["Expression ...", "$$ = new yy.Splat($1);", null]
	],
	"SimpleAssignable": [
		["Identifier", "$$ = new yy.Value($1);", null],
		["Value Accessor", "$$ = $1.add($2);", null],
		["Invocation Accessor", "$$ = new yy.Value($1, [].concat($2));", null],
		["ThisProperty", "$$ = $1;", null]
	],
	"Assignable": [
		["SimpleAssignable", "$$ = $1;", null],
		["Array", "$$ = new yy.Value($1);", null],
		["Object", "$$ = new yy.Value($1);", null]
	],
	"Value": [
		["Assignable", "$$ = $1;", null],
		["Literal", "$$ = new yy.Value($1);", null],
		["Parenthetical", "$$ = new yy.Value($1);", null],
		["Range", "$$ = new yy.Value($1);", null],
		["This", "$$ = $1;", null]
	],
	"Accessor": [
		[". Identifier", "$$ = new yy.Access($2);", null],
		["?. Identifier", "$$ = new yy.Access($2, 'soak');", null],
		[":: Identifier", "$$ = [new yy.Access(new yy.Literal('prototype')), new yy.Access($2)];", null],
		["::", "$$ = new yy.Access(new yy.Literal('prototype'));", null],
		["Index", "$$ = $1;", null]
	],
	"Index": [
		["INDEX_START IndexValue INDEX_END", "$$ = $2;", null],
		["INDEX_SOAK Index", "$$ = yy.extend($2, {\n          soak: true\n        });", null]
	],
	"IndexValue": [
		["Expression", "$$ = new yy.Index($1);", null],
		["Slice", "$$ = new yy.Slice($1);", null]
	],
	"Object": [
		["{ AssignList OptComma }", "$$ = new yy.Obj($2, $1.generated);", null]
	],
	"AssignList": [
		["", "$$ = [];", null],
		["AssignObj", "$$ = [$1];", null],
		["AssignList , AssignObj", "$$ = $1.concat($3);", null],
		["AssignList OptComma TERMINATOR AssignObj", "$$ = $1.concat($4);", null],
		["AssignList OptComma INDENT AssignList OptComma OUTDENT", "$$ = $1.concat($4);", null]
	],
	"Class": [
		["CLASS", "$$ = new yy.Class;", null],
		["CLASS Block", "$$ = new yy.Class(null, null, $2);", null],
		["CLASS EXTENDS Expression", "$$ = new yy.Class(null, $3);", null],
		["CLASS EXTENDS Expression Block", "$$ = new yy.Class(null, $3, $4);", null],
		["CLASS SimpleAssignable", "$$ = new yy.Class($2);", null],
		["CLASS SimpleAssignable Block", "$$ = new yy.Class($2, null, $3);", null],
		["CLASS SimpleAssignable EXTENDS Expression", "$$ = new yy.Class($2, $4);", null],
		["CLASS SimpleAssignable EXTENDS Expression Block", "$$ = new yy.Class($2, $4, $5);", null]
	],
	"Invocation": [
		["Value OptFuncExist Arguments", "$$ = new yy.Call($1, $3, $2);", null],
		["Invocation OptFuncExist Arguments", "$$ = new yy.Call($1, $3, $2);", null],
		["SUPER", "$$ = new yy.Call('super', [new yy.Splat(new yy.Literal('arguments'))]);", null],
		["SUPER Arguments", "$$ = new yy.Call('super', $2);", null]
	],
	"OptFuncExist": [
		["", "$$ = false;", null],
		["FUNC_EXIST", "$$ = true;", null]
	],
	"Arguments": [
		["CALL_START CALL_END", "$$ = [];", null],
		["CALL_START ArgList OptComma CALL_END", "$$ = $2;", null]
	],
	"This": [
		["THIS", "$$ = new yy.Value(new yy.Literal('this'));", null],
		["@", "$$ = new yy.Value(new yy.Literal('this'));", null]
	],
	"ThisProperty": [
		["@ Identifier", "$$ = new yy.Value(new yy.Literal('this'), [new yy.Access($2)], 'this');", null]
	],
	"Array": [
		["[ ]", "$$ = new yy.Arr([]);", null],
		["[ ArgList OptComma ]", "$$ = new yy.Arr($2);", null]
	],
	"RangeDots": [
		["..", "$$ = 'inclusive';", null],
		["...", "$$ = 'exclusive';", null]
	],
	"Range": [
		["[ Expression RangeDots Expression ]", "$$ = new yy.Range($2, $4, $3);", null]
	],
	"Slice": [
		["Expression RangeDots Expression", "$$ = new yy.Range($1, $3, $2);", null],
		["Expression RangeDots", "$$ = new yy.Range($1, null, $2);", null],
		["RangeDots Expression", "$$ = new yy.Range(null, $2, $1);", null],
		["RangeDots", "$$ = new yy.Range(null, null, $1);", null]
	],
	"ArgList": [
		["Arg", "$$ = [$1];", null],
		["ArgList , Arg", "$$ = $1.concat($3);", null],
		["ArgList OptComma TERMINATOR Arg", "$$ = $1.concat($4);", null],
		["INDENT ArgList OptComma OUTDENT", "$$ = $2;", null],
		["ArgList OptComma INDENT ArgList OptComma OUTDENT", "$$ = $1.concat($4);", null]
	],
	"Arg": [
		["Expression", "$$ = $1;", null],
		["Splat", "$$ = $1;", null]
	],
	"SimpleArgs": [
		["Expression", "$$ = $1;", null],
		["SimpleArgs , Expression", "$$ = [].concat($1, $3);", null]
	],
	"Try": [
		["TRY Block", "$$ = new yy.Try($2);", null],
		["TRY Block Catch", "$$ = new yy.Try($2, $3[0], $3[1]);", null],
		["TRY Block FINALLY Block", "$$ = new yy.Try($2, null, null, $4);", null],
		["TRY Block Catch FINALLY Block", "$$ = new yy.Try($2, $3[0], $3[1], $5);", null]
	],
	"Catch": [
		["CATCH Identifier Block", "$$ = [$2, $3];", null]
	],
	"Throw": [
		["THROW Expression", "$$ = new yy.Throw($2);", null]
	],
	"Parenthetical": [
		["( Body )", "$$ = new yy.Parens($2);", null],
		["( INDENT Body OUTDENT )", "$$ = new yy.Parens($3);", null]
	],
	"WhileSource": [
		["WHILE Expression", "$$ = new yy.While($2);", null],
		["WHILE Expression WHEN Expression", "$$ = new yy.While($2, {\n          guard: $4\n        });", null],
		["UNTIL Expression", "$$ = new yy.While($2, {\n          invert: true\n        });", null],
		["UNTIL Expression WHEN Expression", "$$ = new yy.While($2, {\n          invert: true,\n          guard: $4\n        });", null]
	],
	"While": [
		["WhileSource Block", "$$ = $1.addBody($2);", null],
		["Statement WhileSource", "$$ = $2.addBody(yy.Block.wrap([$1]));", null],
		["Expression WhileSource", "$$ = $2.addBody(yy.Block.wrap([$1]));", null],
		["Loop", "$$ = $1;", null]
	],
	"Loop": [
		["LOOP Block", "$$ = new yy.While(new yy.Literal('true')).addBody($2);", null],
		["LOOP Expression", "$$ = new yy.While(new yy.Literal('true')).addBody(yy.Block.wrap([$2]));", null]
	],
	"For": [
		["Statement ForBody", "$$ = new yy.For($1, $2);", null],
		["Expression ForBody", "$$ = new yy.For($1, $2);", null],
		["ForBody Block", "$$ = new yy.For($2, $1);", null]
	],
	"ForBody": [
		["FOR Range", "$$ = {\n          source: new yy.Value($2)\n        };", null],
		["ForStart ForSource", "$$ = (function () {\n        $2.own = $1.own;\n        $2.name = $1[0];\n        $2.index = $1[1];\n        return $2;\n      }());", null]
	],
	"ForStart": [
		["FOR ForVariables", "$$ = $2;", null],
		["FOR OWN ForVariables", "$$ = (function () {\n        $3.own = true;\n        return $3;\n      }());", null]
	],
	"ForValue": [
		["Identifier", "$$ = $1;", null],
		["ThisProperty", "$$ = $1;", null],
		["Array", "$$ = new yy.Value($1);", null],
		["Object", "$$ = new yy.Value($1);", null]
	],
	"ForVariables": [
		["ForValue", "$$ = [$1];", null],
		["ForValue , ForValue", "$$ = [$1, $3];", null]
	],
	"ForSource": [
		["FORIN Expression", "$$ = {\n          source: $2\n        };", null],
		["FOROF Expression", "$$ = {\n          source: $2,\n          object: true\n        };", null],
		["FORIN Expression WHEN Expression", "$$ = {\n          source: $2,\n          guard: $4\n        };", null],
		["FOROF Expression WHEN Expression", "$$ = {\n          source: $2,\n          guard: $4,\n          object: true\n        };", null],
		["FORIN Expression BY Expression", "$$ = {\n          source: $2,\n          step: $4\n        };", null],
		["FORIN Expression WHEN Expression BY Expression", "$$ = {\n          source: $2,\n          guard: $4,\n          step: $6\n        };", null],
		["FORIN Expression BY Expression WHEN Expression", "$$ = {\n          source: $2,\n          step: $4,\n          guard: $6\n        };", null]
	],
	"Switch": [
		["SWITCH Expression INDENT Whens OUTDENT", "$$ = new yy.Switch($2, $4);", null],
		["SWITCH Expression INDENT Whens ELSE Block OUTDENT", "$$ = new yy.Switch($2, $4, $6);", null],
		["SWITCH INDENT Whens OUTDENT", "$$ = new yy.Switch(null, $3);", null],
		["SWITCH INDENT Whens ELSE Block OUTDENT", "$$ = new yy.Switch(null, $3, $5);", null]
	],
	"Whens": [
		["When", "$$ = $1;", null],
		["Whens When", "$$ = $1.concat($2);", null]
	],
	"When": [
		["LEADING_WHEN SimpleArgs Block", "$$ = [[$2, $3]];", null],
		["LEADING_WHEN SimpleArgs Block TERMINATOR", "$$ = [[$2, $3]];", null]
	],
	"IfBlock": [
		["IF Expression Block", "$$ = new yy.If($2, $3, {\n          type: $1\n        });", null],
		["IfBlock ELSE IF Expression Block", "$$ = $1.addElse(new yy.If($4, $5, {\n          type: $3\n        }));", null]
	],
	"If": [
		["IfBlock", "$$ = $1;", null],
		["IfBlock ELSE Block", "$$ = $1.addElse($3);", null],
		["Statement POST_IF Expression", "$$ = new yy.If($3, yy.Block.wrap([$1]), {\n          type: $2,\n          statement: true\n        });", null],
		["Expression POST_IF Expression", "$$ = new yy.If($3, yy.Block.wrap([$1]), {\n          type: $2,\n          statement: true\n        });", null]
	],
	"Operation": [
		["UNARY Expression", "$$ = new yy.Op($1, $2);", null],
		["- Expression", "$$ = new yy.Op('-', $2);",
		{
			"prec": "UNARY"
		}],
		["+ Expression", "$$ = new yy.Op('+', $2);",
		{
			"prec": "UNARY"
		}],
		["-- SimpleAssignable", "$$ = new yy.Op('--', $2);", null],
		["++ SimpleAssignable", "$$ = new yy.Op('++', $2);", null],
		["SimpleAssignable --", "$$ = new yy.Op('--', $1, null, true);", null],
		["SimpleAssignable ++", "$$ = new yy.Op('++', $1, null, true);", null],
		["Expression ?", "$$ = new yy.Existence($1);", null],
		["Expression + Expression", "$$ = new yy.Op('+', $1, $3);", null],
		["Expression - Expression", "$$ = new yy.Op('-', $1, $3);", null],
		["Expression MATH Expression", "$$ = new yy.Op($2, $1, $3);", null],
		["Expression SHIFT Expression", "$$ = new yy.Op($2, $1, $3);", null],
		["Expression COMPARE Expression", "$$ = new yy.Op($2, $1, $3);", null],
		["Expression LOGIC Expression", "$$ = new yy.Op($2, $1, $3);", null],
		["Expression RELATION Expression", "$$ = (function () {\n        if ($2.charAt(0) === '!') {\n          return new yy.Op($2.slice(1), $1, $3).invert();\n        } else {\n          return new yy.Op($2, $1, $3);\n        }\n      }());", null],
		["SimpleAssignable COMPOUND_ASSIGN Expression", "$$ = new yy.Assign($1, $3, $2);", null],
		["SimpleAssignable COMPOUND_ASSIGN INDENT Expression OUTDENT", "$$ = new yy.Assign($1, $4, $2);", null],
		["SimpleAssignable EXTENDS Expression", "$$ = new yy.Extends($1, $3);", null]
	]
}