package primevc.locale;

import haxe.macro.Context;
import haxe.macro.Expr;
import haxe.xml.Fast;
import primevc.utils.FastArray;
import primevc.utils.MacroUtils;


using primevc.utils.StringUtil;
using StringTools;
using Lambda;

enum ElementType {
	leaf;
	plural;
	node;
	func;
}

class LangMacro 
{
	@:macro public static function build() : Array<Field> 
    {      
		var pos = haxe.macro.Context.currentPos();
		var fields = haxe.macro.Context.getBuildFields();
		
		var langsRaw = new Hash<YamlHX>();
		
		for ( dir in Context.getClassPath() )
		{
			var currentDir =  dir + "i18n";
			if (neko.FileSystem.exists(currentDir))
			{
				for (file in  neko.FileSystem.readDirectory(currentDir) )
				{
					if ( file.indexOf(".yaml") > -1 )
					{
						haxe.macro.Context.registerModuleDependency("primevc.locale.LangMacro", currentDir + "/" + file);
						var data = YamlHX.read( neko.io.File.getContent( currentDir + "/" + file) );
						var key = data.x.firstChild().nodeName;
						langsRaw.set(key , data);
					}
				}
			}
		}

	
		if (langsRaw.empty())
		{
			Context.error("There are no .yaml files", pos);
		}
		
		var t = { pack:[], pos:pos, meta:[], params:[], isExtern:false, kind:TDClass(), name:"LangManBindables", fields:[] };
		var constructorWords = "";
		
		var ILangInterfaceType = { pack:"primevc.locale".split("."), pos:pos, meta:[], params:[], isExtern:false, kind:TDClass(null,null,true), name:"ILang", fields:[] };

		var list = [];
		for (yaml in langsRaw) 
		{
			for (lang in yaml.elements)
			{
				// ILang interface generation. Also creates Typedefs.
				list = list.concat ( traverseXMLInterface(lang, ILangInterfaceType.fields) );
			}
		}
		
		var errorList = [];
		for (yaml in langsRaw) 
		{
			var lang = yaml.elements.next();
			for (h in list)
			{
				try
				{
					yaml.get(lang.name +"." +  h);
				}
				catch (msg:String)
				{
					if ( msg.indexOf("YamlHX.get() error") > -1)
					{
						errorList.push("missing " +lang.name + "." + h);
					}
				}
			}
		}
		
		if (errorList.length > 0)
		{
			Context.error( errorList.join("\n" ), pos );
		}

		var defaultLang = langsRaw.iterator().next();
		
		if (defaultLang == null) Context.error("Default language not defined", pos);
		
		
		constructorWords = traverseXMLLangManBind( new Fast(defaultLang.x.firstElement()), t);
		
		t.fields.push( { meta:[], name:"new", doc:null, access:[APublic], kind:FFun( { args:[], ret:null, expr:Context.parse("{" + constructorWords + "}", pos), params:[] } ), pos:pos } );
		
		Context.defineType(ILangInterfaceType);
		Context.defineType(t);
		
		//build types
		
		for (yaml in langsRaw) // for yamls in yamls array
		{
			for (node in yaml.elements) //for each language in each yaml
			{
				var t = { // create Class of Type NameLanguage (Ex Dutch,Spanish) implementing ILang
				  kind:TDClass(null, [ { pack:"primevc.locale".split("."), name:"ILang", params:[ ], sub:null } ], false), name:node.name.capitalizeFirstLetter(),
				  fields:[ ], pack: ["langMan"],  pos:pos, 	meta:[], params:[],	 isExtern:false //added langMan in pack,else Ill get TypeError: Error #1064: 
				};
				
				var constructorWords = "";
				var exprUpdateValues:String = "";
				var previousWordName:String = "";
				
				//traverseXMLGenerateTypes fills languages instances.
				constructorWords = traverseXMLGenerateTypes(node, t, "");
	
				exprUpdateValues = traverseXMLGenerateExpValues(node, "");
				
				//add consturctor to Languages classses
				t.fields.push( { meta:[], name:"new", doc:null, access:[APublic], kind:FFun( { args:[], ret:null, expr:Context.parse("{"+ constructorWords + "}", pos), params:[] } ), pos:pos } );
				
				//create class named Language implementing ILang
				Context.defineType(t);
				
				var cultureClassName = "thx.cultures." + node.name.capitalizeFirstLetter();
				
				try
				{
					Context.getType(cultureClassName);
				}
				catch( msg : String )
				{
					Context.error( cultureClassName + " does not exist",pos);
				}
				
				var currentLang = cultureClassName + ".culture";
				
				
				var expr = Context.parse("{this.current = new langMan." + node.name.capitalizeFirstLetter()  +"();" + exprUpdateValues + " thx.culture.Culture.defaultCulture = "+currentLang +"; this.change.send(); }", pos);
				
				fields.push( { name:node.name, doc:null, meta:[], access:[APublic], kind:FFun(  { args:[], ret:null, expr:expr, params:[] } ), pos:pos } );
			}
		}
	
		return fields;
    }
	
	

	#if macro
	
	static private function traverseXMLGenerateTypes(xml:Fast, typeDefinition:TypeDefinition, ?consLines:String = "" )
	{
		var tint = TPath( { pack : [], name : "String", params : [], sub : null } );
		for (el in xml.elements) 
		{
			switch( getElementType(el) )
			{
				case leaf:
				//trace("1: " + el.name );
				typeDefinition.fields.push( { name : el.name, doc : null, meta : [], access : [APublic], kind : FVar(tint), pos : Context.currentPos() } );
				//
				///*the data for all strings*/
				consLines +=  el.name + "=" + addSlashes( el.innerData) + "; ";
				//
				///*how the data for all strings will be pushed into bindables*/
				
				case plural:
				//TODO: Move this into a  static function
				var farg1:FunctionArg =  { name:"param1", opt:false, type:TPath( { pack : [], name : "Int", params : [], sub : null } ) };
				
				var funcData:String = " { var hash = new Hash<String>();";
				
				for (val in el.elements) 
					funcData +=  "hash.set(" + addSlashes(val.name) + "," + addSlashes(val.innerData) + ");";
				
				funcData += " var result = '';";
				funcData += " if( (hash.exists('zero')) && (param1 == 0) ) { result =  hash.get('zero'); }";
				funcData += "else";
				funcData += "{";
				funcData += " var pluralType = thx.translation.PluralForms.pluralRules[ thx.culture.Culture.defaultCulture.pluralRule]( param1 ); ";
				funcData += " result = hash.get( Std.string(pluralType) );  ";
				funcData += "}";//if
				funcData += " return Strings.format( result, [ param1 ] ); ";
				funcData += "}";
				
				typeDefinition.fields.push( { pos: Context.currentPos(), meta:[], name:el.name, doc:null, access:[APublic], kind:FFun(  { args:[farg1 ], ret:tint, expr:Context.parse(funcData,  Context.currentPos()), params:[] } ) } );
				
				case node:
				//type generated in BuildInterface Method
				var tintStruct = TPath( { pack : [], name :el.name.capitalizeFirstLetter() + "struct" , params : [], sub : null } );
				typeDefinition.fields.push( { pos:Context.currentPos(), meta:[], name:el.name, doc:null, access:[APublic], kind:FVar(tintStruct) } );

				consLines += el.name +" = {" + followAndFill(el, typeDefinition) + "}";
				
				case func:
				var args:Array<FunctionArg> = [];
				var argsString = [];
				//trace(el.innerData);
				var regExp = new EReg("{([^:}]*):?([^}])*}", "");
				
				var auxResult = [];
				var varNames:Array<String> = [];
				var i = -1;
				var nodeParsedValue = regExp.customReplace(el.innerData, function (e) {
					var lastVal =  varNames.indexOf(e.matched(1));
					if (lastVal == -1)
					{
						i++;
						varNames.push( e.matched(1) );
						lastVal = i;
						
					}
					return StringTools.replace(e.matched(0), e.matched(1), Std.string(lastVal));
				});
					
				for ( i in 0 ... varNames.length )
				{
					args.push ( { name:varNames[i] , opt:false, type:MacroExprUtil.createTypePath("Dynamic") } );
				}
				var expFunc = Context.parse("{return Strings.format(" + addSlashes(nodeParsedValue) + "," + varNames + ");}", Context.currentPos());
				typeDefinition.fields.push( { pos:Context.currentPos(), meta:[], name:el.name, doc:null, access:[APublic], kind:FFun(  { args:args, ret:MacroExprUtil.createTypePath("String"), expr:expFunc, params:[] } ) } );
			}

		}
		
		return consLines;
		
	}

	
	static private function  followAndFill(xml:Fast, typeDefinition:TypeDefinition, ?consLines:String = "")
	{
		
		for (el in xml.elements) 
		{
			switch(getElementType(el))
			{
				case leaf:
				consLines += el.name + ":'" + el.innerData  + "',";
				
				case plural:
				var tint = TPath( { pack : [], name : "String", params : [], sub : null } );
				//TODO: this should point to 
				var farg1:FunctionArg =  { name:"param1", opt:false, type:TPath( { pack : [], name : "Int", params : [], sub : null } ) };
				
				var funcData:String = " { var hash = new Hash<String>();";
				
				for (val in el.elements) 
					funcData +=  "hash.set(" + addSlashes(val.name) + "," + addSlashes(val.innerData) + ");";
				
				funcData += " var result = '';";
				funcData += " if( (hash.exists('zero')) && (param1 == 0) ) { result =  hash.get('zero'); }";
				funcData += "else";
				funcData += "{";
				funcData += " var pluralType = thx.translation.PluralForms.pluralRules[ thx.culture.Culture.defaultCulture.pluralRule]( param1 ); ";
				funcData += " result = hash.get( Std.string(pluralType) );  ";
				funcData += "}";//if
				funcData += " return Strings.format( result, [ param1 ] ); ";
				funcData += "}";
				
				typeDefinition.fields.push( { pos: Context.currentPos(), meta:[], name:el.name, doc:null, access:[APublic], kind:FFun(  { args:[farg1 ], ret:tint, expr:Context.parse(funcData,  Context.currentPos()), params:[] } ) } );
				
				consLines += el.name + ":this." + el.name  + ",";
				
				case node:
				consLines += el.name  + ":{";
				consLines += followAndFill(el,typeDefinition);
				consLines += "},";
				
				case func:
				var args:Array<FunctionArg> = [];
				var argsString = [];
				//trace(el.innerData);
				var regExp = new EReg("{([^:}]*):?([^}])*}", "");
				
				var auxResult = [];
				var varNames:Array<String> = [];
				var i = -1;
				var nodeParsedValue = regExp.customReplace(el.innerData, function (e) {
					var lastVal =  varNames.indexOf(e.matched(1));
					if (lastVal == -1)
					{
						i++;
						varNames.push( e.matched(1) );
						lastVal = i;
						
					}
					return StringTools.replace(e.matched(0), e.matched(1), Std.string(lastVal));
				});
					
				for ( i in 0 ... varNames.length )
				{
					args.push ( { name:varNames[i] , opt:false, type:MacroExprUtil.createTypePath("Dynamic") } );
				}
				var expFunc = Context.parse("{return Strings.format(" + addSlashes(nodeParsedValue) + "," + varNames + ");}", Context.currentPos());
				typeDefinition.fields.push( { pos:Context.currentPos(), meta:[], name:el.name, doc:null, access:[APublic], kind:FFun(  { args:args, ret:MacroExprUtil.createTypePath("String"), expr:expFunc, params:[] } ) } );
				consLines += el.name + ":this." + el.name  + ",";

			}
		}
		return consLines;
	}
	
	static private function followAndFillBindables(xml:Fast, ?consLines:String = "" )
	{
		for (el in xml.elements) 
		{
			switch( getElementType(el) )
			{
				case leaf:
				consLines += el.name + ":" + "new primevc.core.Bindable<String>('" + el.innerData+"')"  + ",";
				
				case node:
				consLines += el.name  + ":{";
				consLines += followAndFillBindables(el);
				consLines += "},";
				
				case func:
				case plural:
			}
		}
		return consLines;
	}
	
	
	
	static private function traverseXMLGenerateExpValues(xml:Fast, ?parent:String = "" )
	{
		var result = "";
		//TODO: this method write the strings for pusshing the values of any language into langman.bindables
		//exprUpdateValues += "bindables." + word.name + ".value = this.current." + word.name + ";";
		for (el in xml.elements) 
		{
			switch( getElementType(el) )
			{
				case leaf:
				result +=  "this.bindables." + (parent.length > 0? parent + "." : "") + el.name + ".value = this.current." + (parent.length > 0?parent + "." : "") +el.name +";";
				
				case node:
				result += traverseXMLGenerateExpValues(el, (parent.length > 0? parent + "." : "")  + el.name);
				
				case func:
				case plural:
			}
		}
		return result;
	}
	
	static private function getElementType(xml:Fast)
	{
		if ( isFunction(xml) )	return func;
		if ( isLeaf(xml) )		return leaf;
		if ( isPlural(xml) )	return plural;
		return node;
	}
	

	static private inline function isLeaf(xml:Fast)
	{
		return !xml.elements.hasNext();
	}
	
	static private inline function isPlural(xml:Fast)
	{
		return xml.has.plural;
	}
	
	static private inline function isFunction(xml:Fast)
	{
		return xml.has.func;
	}
	

	

	static private function traverseXMLInterface(xml:Fast, fields:Array<Field>, ?parent:String = "")
	{
		var result = [];
		var tintString = TPath( { pack : [], name : "String", params : [], sub : null } );
		for (el in xml.elements) 
		{
			result.push( parent + (parent.length > 0?".":"") + el.name);
			if (  MacroExprUtil.getField( fields, el.name) == null )
			{
				switch(getElementType(el))
				{
					
					case leaf:
					fields.push( { name :el.name, doc : null, meta : [], access : [APublic], kind :FieldType.FVar(TPath( { pack : [], name : "String", params : [], sub : null } )), pos : Context.currentPos() }   );
					
					case plural:
					var farg1:FunctionArg =  { name:"val", opt:false, type:TPath( { pack : [], name : "Int", params : [], sub : null } ) };
					fields.push( { pos:Context.currentPos(), meta:[], name:el.name, doc:null, access:[APublic], kind:FFun(  { args:[farg1 ], ret:tintString, expr:null, params:[] } ) } );

					case node:
					var t = { 
					  kind:TDStructure, name: el.name.capitalizeFirstLetter() + "struct" ,
					  fields:[ ], pack: [],  pos:Context.currentPos(), 	meta:[], params:[], isExtern:false
					};
					
					fields.push( { name :el.name, doc : null, meta : [], access : [APublic], kind :FieldType.FVar(TPath( { pack : [], name : t.name, params : [], sub : null } )), pos : Context.currentPos() }   );
					result = result.concat(traverseXMLInterface(el, t.fields, parent + (parent.length > 0?".":"")  + el.name) );
					Context.defineType(t);
						
					case func:
					var argsCount =  el.att.func;
					var args:Array<FunctionArg> = [];
					
					var regExp = new EReg("{([^:}]*):?([^}])*}", "");
				
					var varNames:Array<String> = [];
					regExp.customReplace(el.innerData, function (e) {
						if (varNames.indexOf(e.matched(1)) == -1)
						{
							varNames.push( e.matched(1) );
						}
						return "";
					});
						
					for ( i in 0 ... varNames.length )
					{
						args.push ( { name:varNames[i] , opt:false, type:TPath( { pack : [], name : "Dynamic", params : [], sub : null } ) } );
					}
					
					fields.push( { pos:Context.currentPos(), meta:[], name:el.name, doc:null, access:[APublic], kind:FFun(  { args:args, ret:tintString, expr:null, params:[] } ) } );
					
					
				}
			}
		}
		return result;
	}
	
	
	static private function traverseXMLLangManBind(xml:Fast, type:TypeDefinition, ?constructorLines:String = "")
	{
		
		for (el in xml.elements) 
		{
			switch( getElementType(el))
			{
				case leaf:
				type.fields.push( { name :el.name, doc : null, meta : [], access : [APublic], kind :FieldType.FVar(TPath( { pack : ["primevc", "core"], name : "Bindable", params : [ TPType( TPath( { pack : [], name : "String", params : [], sub : null } )) ], sub :null } )), pos : Context.currentPos() }   );
				
				//constructor data for LagManBinds
				constructorLines +=  el.name + " = new primevc.core.Bindable<String>('" +  el.innerData + "');";

				case plural:
				//not bindable
				
				case node:
				var t = { 
				kind:TDStructure, name: el.name.capitalizeFirstLetter() + "structBindable" ,
				fields:[ ], pack: [],  pos:Context.currentPos(), 	meta:[], params:[], isExtern:false
				};

				type.fields.push( { name :el.name, doc : null, meta : [], access : [APublic], kind :FieldType.FVar(TPath( { pack : [], name : t.name, params : [], sub : null } )), pos : Context.currentPos() }   );
				traverseXMLLangManBind(el, t, constructorLines);
				
				constructorLines += el.name +" = {" + followAndFillBindables(el) + "}";
				Context.defineType(t);

				case func:
			}
		}
		return  constructorLines;
	}
	
	
	static function traverseXMLFunction(xml:Fast, f:Null<Dynamic> -> Null<Dynamic>, ?optArray:Array<Dynamic>)
	{
		//TODO:
		for (el in xml.elements) 
		{
			if ( isLeaf( el) )
			{
				f(el);
			}
			else if( el.has.plural )
			{
				f(el);
			}
			else
			{ 
				traverseXMLFunction(el, f, optArray);
			}
		}
	}
	

	private static inline function addSlashes(s)
	{
		return '"' + s + '"';
	}
	

	#end
}
