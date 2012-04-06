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
		
		var previousWordName:String = "";
		
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
				

				for (word in node.elements) 
				{
					if ( word.has.func)
					{
						if ( previousWordName != word.name)
						{
						
							previousWordName = word.name;

							var expr = Context.parse("{return Std.string(val);}", pos);
							var farg1:FunctionArg =  { name:"val", opt:false, type:TPath( { pack : [], name : "Int", params : [], sub : null } ) };
							t.fields.push( { pos:pos, meta:[], name:word.name, doc:null, access:[APublic], kind:FFun(  { args:[farg1 ], ret:tint, expr:expr, params:[] } ) } );
						}
					}
					else
					{
						t.fields.push( { name : word.name, doc : null, meta : [], access : [APublic], kind : FVar(tint), pos : pos } );
						constructorWords +=  word.name + "=" + addSlashes( word.innerData) + ";";
						exprUpdateValues += "langBind." + word.name + ".value = this.lang." + word.name + ";";
					}
				}
				
				//add consturctor to Languages classses
				t.fields.push( { meta:[], name:"new", doc:null, access:[APublic], kind:FFun( { args:[], ret:null, expr:Context.parse("{"+ constructorWords + "}", pos), params:[] } ), pos:pos } );
				
				//create class named Language implementing ILang
				Context.defineType(t);

				//add methods for changing langman language
				//TODO: Make languages instance singletons
				var expr = Context.parse("{this.lang = new " + StringUtil.capitalizeFirstLetter(node.name)  +"(); this.changed.send(); " + exprUpdateValues+"}", pos);
				
				fields.push( { name:node.name, doc:null, meta:[], access:[APublic], kind:FFun(  { args:[], ret:null, expr:expr, params:[] } ), pos:pos } );
			}
		}

		//add signal
		fields.push ( { name:"changed", doc:null, meta:[], access:[APublic], kind:FVar( TPath( { pack : ["primevc", "core", "dispatcher"], name : "Signal0", params : [], sub : null } )),  pos:pos } );
		//add field lang:Ilang
		fields.push ( { name:"lang", doc:null, meta:[], access:[APrivate], kind:FVar( TPath( { pack:[], name:"ILang", params:[ ], sub:null } )),  pos:pos } );
		//add field holdings bindables
		fields.push ( { name:"langBind", doc:null, meta:[], access:[APublic], kind:FVar( TPath( { pack:[], name:"LangManBinds", params:[ ], sub:null } )),  pos:pos } );
		
		fields.push ( { meta:[], name:"new", doc:null, access:[APublic], kind:FFun( { args:[], ret:null, expr:Context.parse("{ this.changed = new primevc.core.dispatcher.Signal0(); this.langBind = new LangManBinds();}", pos), params:[] } ), pos:pos } );
		
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
		
		
		//LangManBinds  is the class intance which acts as client, it have binables and a private field called lang which is the actual language being used
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
							//var expr = Context.parse("{}", pos);
				
							//fields.push( { name:node.name, doc:null, meta:[], access:[APublic], kind:FFun(  { args:[], ret:null, expr:expr, params:[] } ), pos:pos } );
				
							//fields.push( { pos:pos, meta:[], name:word.name, doc:null, access:[APublic], kind:FFun(tint) } );
							//type function
							var farg1:FunctionArg =  { name:"val", opt:false, type:TPath( { pack : [], name : "Int", params : [], sub : null } ) };
							fields.push( { pos:pos, meta:[], name:word.name, doc:null, access:[APublic], kind:FFun(  { args:[farg1 ], ret:tint, expr:null, params:[] } ) } );
							
							//var expr = Context.parse("{ return this.lang." + word.name  +"(val);}" , pos);
							var expr = Context.parse("{ return 'sting';}" , pos);
							
							t.fields.push( { pos:pos, meta:[], name:word.name, doc:null, access:[APublic], kind:FFun(  { args:[farg1 ], ret:tint, expr:expr, params:[] } ) } );
						}
						else
						{
							//add string fields to ILang Intarface
							fields.push( { pos:pos, meta:[], name:word.name, doc:null, access:[APublic], kind:FVar(tint) } );
							//add Bindables to LagManBinds wrapper
							t.fields.push( { pos:pos, meta:[], name:word.name, doc:null, access:[APublic], kind:FVar(tintBindable) } );
							//constructor data for LagManBinds
							constructorWords +=  word.name + " = new primevc.core.Bindable<String>('" + word.innerData + "');";
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
