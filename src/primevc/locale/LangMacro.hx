package primevc.locale;

import haxe.macro.Context;
import haxe.macro.Expr;
import haxe.xml.Fast;
import primevc.utils.FastArray;
import primevc.utils.MacroUtils;


using primevc.utils.StringUtil;
using StringTools;

class LangMacro 
{
	
	
	@:macro static public function buildInterface()  :Array<Field> 
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
						var key = file.replace(".yaml", "");
						langsRaw.set(key , YamlHX.read( neko.io.File.getContent( currentDir + "/" + file) ));
					}
				}
			}
		}

		var t = { pack:[], pos:pos, meta:[], params:[], isExtern:false, kind:TDClass(), name:"LangManBindables", fields:[] };
		
		var constructorWords = "";
	

		for (yaml in langsRaw) 
		{
			for (lang in yaml.elements)
			{
				// ILang interface generation. Also creates Typedefs.
				traverseXMLInterface(lang, fields);
			}
		}
		
		var defaultLang = langsRaw.get("EnNZ");
		
		constructorWords = traverseXMLLangManBind(defaultLang, t);
		
		t.fields.push( { meta:[], name:"new", doc:null, access:[APublic], kind:FFun( { args:[], ret:null, expr:Context.parse("{" + constructorWords + "}", pos), params:[] } ), pos:pos } );
		
		Context.defineType(t);
	
		return fields;
	}
	

	@:macro public static function build() : Array<Field> 
    {        

		var pos = haxe.macro.Context.currentPos();
		var fields = haxe.macro.Context.getBuildFields();
		
		var tint = TPath( { pack : [], name : "String", params : [], sub : null } );
		
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
						langsRaw.set(file , YamlHX.read( neko.io.File.getContent( currentDir + "/" + file) ));
					}
				}
			}
		}
		
		
		
		for (yaml in langsRaw) // for yamls in yamls array
		{
			for (node in yaml.elements) //for each language in each yaml
			{
				var t = { // create Class of Type NameLanguage (Ex Dutch,Spanish) implementing ILang
				  kind:TDClass(null, [ { pack:"primevc.locale".split("."), name:"ILang", params:[ ], sub:null } ], false), name:node.name.capitalizeFirstLetter(),
				  fields:[ ], pack: [],  pos:pos, 	meta:[], params:[],	 isExtern:false
				};
				
				var constructorWords = "";
				var exprUpdateValues:String = "";
				var previousWordName:String = "";
				
				//traverseXMLGenerateTypes fills languages instances.
				//ATM only top level strings and functions are working. Remains to get  all values enclosed in a sublevel  working. Ex. level1.level2. wont work.
				constructorWords = traverseXMLGenerateTypes(node, t, "");
				

				//TODO: this method write the strings for pusshing the values of any language into langman.bindables
				exprUpdateValues = traverseXMLGenerateExpValues(node);
				

				//add consturctor to Languages classses
				t.fields.push( { meta:[], name:"new", doc:null, access:[APublic], kind:FFun( { args:[], ret:null, expr:Context.parse("{"+ constructorWords + "}", pos), params:[] } ), pos:pos } );
				
				//create class named Language implementing ILang
				Context.defineType(t);

				//add methods for changing langman language
				//TODO: Make languages instance singletons}
				
				
				//check if culture exists in thx
				
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
				
				var expr = Context.parse("{this.current = new " + node.name.capitalizeFirstLetter()  +"();" + exprUpdateValues +" thx.culture.Culture.defaultCulture = "+currentLang +"; this.change.send(); }", pos);
				
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
			if ( isLeaf( el) )
			{
				//trace("1: " + el.name );
				typeDefinition.fields.push( { name : el.name, doc : null, meta : [], access : [APublic], kind : FVar(tint), pos : Context.currentPos() } );
				//
				///*the data for all strings*/
				consLines +=  el.name + "=" + addSlashes( el.innerData) + "; ";
				//
				///*how the data for all strings will be pushed into bindables*/
				
			}
			else if( el.has.func )
			{

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
			}
			else
			{ 
				//type generated in BuildInterface Method
				var tintStruct = TPath( { pack : [], name :el.name.capitalizeFirstLetter() + "struct" , params : [], sub : null } );

				typeDefinition.fields.push( { pos:Context.currentPos(), meta:[], name:el.name, doc:null, access:[APublic], kind:FVar(tintStruct) } );

				consLines += el.name +" = {" + followAndFill(el) + "}";
			}
		}
		
		return consLines;
		
	}

	
	static private function  followAndFill(xml:Fast, ?consLines:String = "" )
	{
		for (el in xml.elements) 
		{
			if ( isLeaf( el) )
			{
				consLines += el.name + ":'" + el.innerData  + "',";
			}
			else if ( el.has.func)
			{
				consLines += el.name + ":'" + el.innerData  + "',";
			}
			else
			{
				consLines += el.name  + ":{";
				consLines += followAndFill(el);
				consLines += "}";
			}
		}
		return consLines;
	}
	
	
	
	static private function traverseXMLGenerateExpValues(xml:Fast )
	{
		var result = "";
		//TODO: this method write the strings for pusshing the values of any language into langman.bindables
		//exprUpdateValues += "bindables." + word.name + ".value = this.current." + word.name + ";";
		for (el in xml.elements) 
		{
			if ( isLeaf( el) )
			{
				result +=  "this.bindables." + el.name + ".value = this.current." +el.name +";";
			}
			else if ( el.has.func)
			{
				
			}
			else
			{
				//result += traverseXMLGenerateExpValues(el);
			}
		}
		return result;
	}
	

	static public inline function isLeaf(xml:Fast)
	{
		return !xml.elements.hasNext();
		
	}

	

	static private function traverseXMLInterface(xml:Fast,fields:Array<Field>) 
	{
		
		var tintString = TPath( { pack : [], name : "String", params : [], sub : null } );
		for (el in xml.elements) 
		{

			if (  MacroExprUtil.getField( fields, el.name) == null )
			{
				if ( isLeaf( el) )
				{
					fields.push( { name :el.name, doc : null, meta : [], access : [APublic], kind :FieldType.FVar(TPath( { pack : [], name : "String", params : [], sub : null } )), pos : Context.currentPos() }   );
				}
				else
				{
					if( el.has.func )
					{
						var farg1:FunctionArg =  { name:"val", opt:false, type:TPath( { pack : [], name : "Int", params : [], sub : null } ) };
						fields.push( { pos:Context.currentPos(), meta:[], name:el.name, doc:null, access:[APublic], kind:FFun(  { args:[farg1 ], ret:tintString, expr:null, params:[] } ) } );
					}
					else
					{
						var t = { 
						  kind:TDStructure, name: el.name.capitalizeFirstLetter() + "struct" ,
						  fields:[ ], pack: [],  pos:Context.currentPos(), 	meta:[], params:[], isExtern:false
						};
						
						fields.push( { name :el.name, doc : null, meta : [], access : [APublic], kind :FieldType.FVar(TPath( { pack : [], name : t.name, params : [], sub : null } )), pos : Context.currentPos() }   );
						traverseXMLInterface(el, t.fields);
						Context.defineType(t);
					}
				}
			}
		}
	}
	
	
	static private function traverseXMLLangManBind(xml:Fast, type:TypeDefinition, ?constructorLines:String = "")
	{
		
		//TODO: Add Tree
		for (el in xml.elements) 
		{
			if ( isLeaf( el) )
			{
				if (  MacroExprUtil.getField( type.fields, el.name) == null )
					type.fields.push( { name :el.name, doc : null, meta : [], access : [APublic], kind :FieldType.FVar(TPath( { pack : ["primevc", "core"], name : "Bindable", params : [ TPType( TPath( { pack : [], name : "String", params : [], sub : null } )) ], sub :null } )), pos : Context.currentPos() }   );
				
				//constructor data for LagManBinds
				constructorLines +=  el.name + " = new primevc.core.Bindable<String>('" +  el.innerData + "');";
			}
			else if( el.has.func )
			{
				//not bindable
			}
			else
			{ 
				constructorLines = traverseXMLLangManBind(el, type, constructorLines);
			}
	
		}
		return  constructorLines;
	}
	
	
	static function traverseXMLFunction(xml:Fast, f:Null<Dynamic> -> Null<Dynamic>, ?optArray:Array<Dynamic>)
	{
		for (el in xml.elements) 
		{
			if ( isLeaf( el) )
			{
				f(el);
			}
			else if( el.has.func )
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
	
		private static inline function simpleTPath(s:String)
	{
		return TPath( { pack : [] , name : s, params : [], sub : null } );
	}
	
	private static inline function simpleTPathString()
	{
		return simpleTPath("String");
	}
	#end
}
