package primevc.locale;

import haxe.macro.Context;
import haxe.macro.Expr;
import primevc.utils.StringUtil;



class LangMacro 
{
    @:macro public static function build() : Array<Field> 
    {        
		var pos = haxe.macro.Context.currentPos();
		var fields = haxe.macro.Context.getBuildFields();
		
		var yaml = YamlHX.read(neko.io.File.getContent('test.yaml'));
		var langs = yaml.node.languages.elements;
		
		var tint = TPath( { pack : [], name : "String", params : [], sub : null } );
		//var tint = TPath( { pack : ["primevc", "core"], name : "Bindable", params : [ TPType( TPath( { pack : [], name : "String", params : [], sub : null } )) ], sub :null } );
		
		for (node in langs)
		{
			var words = node.elements;
			var constructorWords = "";
			var t = {
			  pack: [],  pos:pos, 	meta:[], params:[],	 isExtern:false, kind:TDClass(null, [ { pack:"primevc.locale".split("."), name:"ILang", params:[ ], sub:null } ], false),	 name: node.name.substr(0, 1).toUpperCase() + node.name.substr(1),
			  fields:[/* {meta:[], name:"new", doc:null, access:[APublic], kind:FFun( { args:[], ret:null, expr:Context.parse("{}", pos), params:[] } ), pos:pos }*/ ],
			};

			var exprUpdateValues:String = "";
			for (word in words) 
			{
			  //var str =  Context.parse('"' + word.innerData +' "', Context.currentPos()) ;
			  t.fields.push( { name : word.name, doc : null, meta : [], access : [APublic], kind : FVar(tint), pos : pos } );
			  //trace( word.name + "=" + addSlashes( word.innerData) + ";");
			  constructorWords +=  word.name + "=" + addSlashes( word.innerData) + ";";
			  exprUpdateValues += "langBind." + word.name+ ".value = this.lang." + word.name + ";";
			  
			}
			
			//trace(exprUpdateValues);

			//constructorWords += "this.changed = new primevc.core.dispatcher.Signal0();";
			//add consturctor to Languages classses
			t.fields.push( { meta:[], name:"new", doc:null, access:[APublic], kind:FFun( { args:[], ret:null, expr:Context.parse("{"+ constructorWords + "}", pos), params:[] } ), pos:pos } );
			
			//create class named Language implementing ILang
			Context.defineType(t);

			//add methods for changing langman language
			var expr = Context.parse("{this.lang = new " + node.name.substr(0, 1).toUpperCase() + node.name.substr(1) +"(); this.changed.send(); " + exprUpdateValues+"}", pos);
			
			
			var lines:String = "this.lang = new " + StringUtil.capitalizeFirstLetter(node.name) + "();";
			for (word in words) 
			{
				trace(word);
			}
			
			
			
			
			fields.push( { name:node.name, doc:null, meta:[], access:[APublic], kind:FFun(  { args:[], ret:null, expr:expr, params:[] } ), pos:pos } );
			
			
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
		var yaml = YamlHX.read(neko.io.File.getContent('test.yaml'));

		var refLang = yaml.node.languages.node.dutch; //Interface vars are created based in this language ( Dutch)
		
		var t = {
			pack: [],  pos:pos, 	meta:[], params:[],	 isExtern:false, kind:TDClass(null, [ ], false),	 name: "LangManBinds",
			fields:[ /*{meta:[], name:"new", doc:null, access:[APublic], kind:FFun( { args:[], ret:null, expr:Context.parse("{}", pos), params:[] } ), pos:pos } */],
		};

			
	
		var constructorWords = "";
		for (word in refLang.elements) 
		{
			fields.push( { pos:pos, meta:[], name:word.name, doc:null, access:[APublic], kind:FVar(tint) } );
			t.fields.push( { pos:pos, meta:[], name:word.name, doc:null, access:[APublic], kind:FVar(tintBindable) } );
			constructorWords +=  word.name + " = new primevc.core.Bindable<String>('"+ word.innerData + "');";
			// + "= new primevc.core.bindable.Bindable<String>("");"
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
