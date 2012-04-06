package primevc.locale;

import haxe.macro.Context;
import haxe.macro.Expr;
import primevc.utils.FastArray;
import primevc.utils.StringUtil;



class LangMacro 
{
    @:macro public static function build() : Array<Field> 
    {        
		var pos = haxe.macro.Context.currentPos();
		var fields = haxe.macro.Context.getBuildFields();
		
		var tint = TPath( { pack : [], name : "String", params : [], sub : null } );
		//var tint = TPath( { pack : ["primevc", "core"], name : "Bindable", params : [ TPType( TPath( { pack : [], name : "String", params : [], sub : null } )) ], sub :null } );
		
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
				  kind:TDClass(null, [ { pack:"primevc.locale".split("."), name:"ILang", params:[ ], sub:null } ], false), name:StringUtil.capitalizeFirstLetter(node.name),
				  fields:[ ], pack: [],  pos:pos, 	meta:[], params:[],	 isExtern:false
				};
				
				var constructorWords = "";
				var exprUpdateValues:String = "";
				var previousWordName:String = "";

				for (word in node.elements) 
				{
					if ( word.has.func)
					{
						if ( previousWordName != word.name)
						{
						
							previousWordName = word.name;

							var farg1:FunctionArg =  { name:"param1", opt:false, type:TPath( { pack : [], name : "Int", params : [], sub : null } ) };
							
							var funcData = "{var result = switch(param1){";
							
							for (val in word.elements) 
							{
								if (val.name != "n")
								{
									funcData += "case " + val.name +":" + addSlashes(val.innerData) + ";";
								}
								else
								{
									funcData +="default:" + addSlashes(val.innerData) + ";";
								}
							}
							funcData += "}";
							
							funcData += "return StringTools.replace(result, '%1', Std.string(param1));}";
							
							t.fields.push( { pos:pos, meta:[], name:word.name, doc:null, access:[APublic], kind:FFun(  { args:[farg1 ], ret:tint, expr:Context.parse(funcData, pos), params:[] } ) } );
							
						}
					}
					else
					{
						t.fields.push( { name : word.name, doc : null, meta : [], access : [APublic], kind : FVar(tint), pos : pos } );
						
						//the data for all strings
						constructorWords +=  word.name + "=" + addSlashes( word.innerData) + ";";
						
						//how the data for all strings will be pushed into bindables
						exprUpdateValues += "langBind." + word.name + ".value = this.current." + word.name + ";";
					}
				}
				
				//add consturctor to Languages classses
				t.fields.push( { meta:[], name:"new", doc:null, access:[APublic], kind:FFun( { args:[], ret:null, expr:Context.parse("{"+ constructorWords + "}", pos), params:[] } ), pos:pos } );
				
				//create class named Language implementing ILang
				
				Context.defineType(t);

				//add methods for changing langman language
				//TODO: Make languages instance singletons
				var expr = Context.parse("{this.current = new " + StringUtil.capitalizeFirstLetter(node.name)  +"(); this.changed.send(); " + exprUpdateValues+"}", pos);
				
				fields.push( { name:node.name, doc:null, meta:[], access:[APublic], kind:FFun(  { args:[], ret:null, expr:expr, params:[] } ), pos:pos } );
			}
		}

		return fields;
    }
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	@:macro static public function buildInterface()  :Array<Field> 
	{
		var pos = haxe.macro.Context.currentPos();
		var fields = haxe.macro.Context.getBuildFields();
		
		var tint = TPath( { pack : [], name : "String", params : [], sub : null } );
		var tintBindable = TPath( { pack : ["primevc", "core"], name : "Bindable", params : [ TPType( TPath( { pack : [], name : "String", params : [], sub : null } )) ], sub :null } );
		
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
		
		

		var t = { pack:[], pos:pos, meta:[], params:[], isExtern:false, kind:TDClass(), name:"LangManBinds", fields:[] };
		var hash = new Hash<Bool>();
		var constructorWords = "";
		
		for (yaml in langsRaw) 
		{
			for (lang in yaml.elements)
			{
				for (word in lang.elements) 
				{
					//trace(word.has.func);
					if (!hash.exists(word.name))
					{
						if ( word.has.func) // if current word is a function. Ex Comments
						{

							var farg1:FunctionArg =  { name:"val", opt:false, type:TPath( { pack : [], name : "Int", params : [], sub : null } ) };
							fields.push( { pos:pos, meta:[], name:word.name, doc:null, access:[APublic], kind:FFun(  { args:[farg1 ], ret:tint, expr:null, params:[] } ) } );
						}
						else
						{
							//add string fields to ILang Intarface
							fields.push( { pos:pos, meta:[], name:word.name, doc:null, access:[APublic], kind:FVar(tint) } );
							
							//add Bindables to LagManBinds wrapper
							t.fields.push( { pos:pos, meta:[], name:word.name, doc:null, access:[APublic], kind:FVar(tintBindable) } );
							
							//constructor data for LagManBinds
							//constructorWords +=  word.name + " = new primevc.core.Bindable<String>('" + word.innerData + "');";
							constructorWords +=  word.name + " = new primevc.core.Bindable<String>('undefinedstring');";
							
						}
						hash.set(word.name, true);	
					}
				}
			}
		}

		t.fields.push( { meta:[], name:"new", doc:null, access:[APublic], kind:FFun( { args:[], ret:null, expr:Context.parse("{" + constructorWords + "}", pos), params:[] } ), pos:pos } );
			
		Context.defineType(t);
		
		return fields;
	}
	
	#if macro
	private static inline function addSlashes(s)
	{
		return '"' + s + '"';
	}
	#end
}
