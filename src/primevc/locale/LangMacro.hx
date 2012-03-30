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

		
		for (yaml in langsRaw) 
		{
			for (node in yaml.elements)
			{
				var t = {
				  fields:[ ],pack: [],  pos:pos, 	meta:[], params:[],	 isExtern:false, kind:TDClass(null, [ { pack:"primevc.locale".split("."), name:"ILang", params:[ ], sub:null } ], false),name:StringUtil.capitalizeFirstLetter(node.name),
				};
				
				var constructorWords = "";
				var exprUpdateValues:String = "";
				
				for (word in node.elements) 
				{
					//fields.push( { pos:pos, meta:[], name:word.name, doc:null, access:[APublic], kind:FVar(tint) } );
					//t.fields.push( { pos:pos, meta:[], name:word.name, doc:null, access:[APublic], kind:FVar(tintBindable) } );
					//constructorWords +=  word.name + " = new primevc.core.Bindable<String>('" + word.innerData + "');";
					t.fields.push( { name : word.name, doc : null, meta : [], access : [APublic], kind : FVar(tint), pos : pos } );
					constructorWords +=  word.name + "=" + addSlashes( word.innerData) + ";";
					exprUpdateValues += "langBind." + word.name+ ".value = this.lang." + word.name + ";";
				}
				
				//add consturctor to Languages classses
				t.fields.push( { meta:[], name:"new", doc:null, access:[APublic], kind:FFun( { args:[], ret:null, expr:Context.parse("{"+ constructorWords + "}", pos), params:[] } ), pos:pos } );
				
				//create class named Language implementing ILang
				Context.defineType(t);

				//add methods for changing langman language
				var expr = Context.parse("{this.lang = new " + node.name.substr(0, 1).toUpperCase() + node.name.substr(1) +"(); this.changed.send(); " + exprUpdateValues+"}", pos);
				
				
				var lines:String = "this.lang = new " + StringUtil.capitalizeFirstLetter(node.name) + "();";

				
				
				
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
		

		var t = { pack:[], pos:pos, meta:[], params:[], isExtern:false, kind:TDClass(), name:"LangManBinds", fields:[] };
		var hash = new Hash<Bool>();
		var constructorWords = "";
		
		for (yaml in langsRaw) 
		{
			for (lang in yaml.elements)
			{
				for (word in lang.elements) 
				{
					if (!hash.exists(word.name))
					{
						fields.push( { pos:pos, meta:[], name:word.name, doc:null, access:[APublic], kind:FVar(tint) } );
						t.fields.push( { pos:pos, meta:[], name:word.name, doc:null, access:[APublic], kind:FVar(tintBindable) } );
						constructorWords +=  word.name + " = new primevc.core.Bindable<String>('" + word.innerData + "');";
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
