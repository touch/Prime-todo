package primevc.locale;
/* The BSD 2-Clause Licence

Copyright (c) 2011, YamlHX Contributors
All rights reserved.
Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

  - Redistributions of source code must retain the above copyright
    notice, this list of conditions and the following disclaimer.
    
  - Redistributions in binary form must reproduce the above copyright
    notice, this list of conditions and the following disclaimer in the
    documentation and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
POSSIBILITY OF SUCH DAMAGE.
*/
import haxe.xml.Fast;
class YamlHX extends Fast
{
	private static inline var LINE_SEPARATOR = "\n";
	public var anchors: Hash<Xml>;
	
	public function new(input:String)
	{
	  anchors = new Hash<Xml>();
		var x:Xml = Xml.parse('<YamlHX xmlns="tag:yaml.org,2002" xmlns:yaml="tag:yaml.org,2002"></YamlHX>');
		x.addChild(Xml.createProlog('xml version="1.0" encoding="utf-8"'));
		
		var line = 0;
		var lines = input.split(LINE_SEPARATOR);
		var indents = 0;
		var spaces = 0;
		var colon = 0;
		var key = "";
		var root = x.firstElement();
		var levels: Array<Xml> = [root]; // level0 is last direct descendant of root
		var value = "";
		var new_element: Xml;
		var tabbing = "";
		var block = false;
		
		for(l in lines){
			line++;
			
			if(StringTools.trim(l) != "" || block){ // empty line, skip unless part of a block
				
				colon = l.indexOf(":");
				
				// convert left tabs to spaces
				l = tabsToSpaces(l,colon);
				
				// count the spaces
				spaces = countSpaces(l);
				
				// set tabbing if it's unset
				if(tabbing == "" && spaces > 0){
					tabbing = StringTools.rpad(tabbing, " ", spaces);
				}
				
				// if block
				if(colon < 0){
					if(block){
						value = l;
						// ltrim the leading tabs
						while(indents > 0 && StringTools.startsWith(value,tabbing)){
							value = value.substr(spaces);
						}
						
						// append new line
            if(levels[indents].firstChild() == null){
              levels[indents].addChild(Xml.createPCData(value));
            }else{
#if (flash9 || flash10)
              levels[indents].nodeValue += value;
#else
              levels[indents].firstChild().nodeValue += value;
#end
            }
					}else if(StringTools.trim(l) == "-"){ // list items
					  new_element = Xml.createElement("_"); // <_>
					  
					  // set indents
  					indents = 0;
  					while(spaces > 0 && StringTools.startsWith(l,tabbing)){
  						l = l.substr(tabbing.length);
  						indents++;
  					}
  					
  					if(spaces > 0){
  						levels[indents-1].addChild(new_element);
  					}else{
  						root.addChild(new_element);
  					}

  					levels[indents] = new_element;
					}else{
						throw "YAML Syntax error at line: "+line;
					}
				}else{
				  block = false;
					key = l.substr(0,colon);
			
					// set indents
					indents = 0;
					while(spaces > 0 && StringTools.startsWith(key,tabbing)){
						key = key.substr(tabbing.length);
						indents++;
					}
					var regExp = new EReg("{([^:}]*):?([^}])*}", "");
					
				    
					
					value = StringTools.trim(l.substr(colon+1));
					new_element = Xml.createElement(StringTools.trim(key));
					if(value != ""){
						if(StringTools.trim(value) == "|"){ // multiline block
							block = true;
						}else if(StringTools.startsWith(StringTools.ltrim(value),"&")){ // yaml anchor
              new_element.set("yaml-anchor", value.substr(value.indexOf("&")+1)); // should be yaml:anchor
						  anchors.set(value.substr(value.indexOf("&")+1), new_element);
						}else if(StringTools.startsWith(StringTools.ltrim(value),"*")){ // yaml alias
              new_element.set("yaml-alias", value.substr(value.indexOf("*")+1)); // should be yaml:alias
						} else if (StringTools.trim(value) == "!!pl") // !!type func hack
						{
							new_element.set("plural", "plural");
						} else if ( regExp.match(StringTools.trim(value))) // TODO: Move to LangMan
						{
							//TODO: check if plural, ignore
							var auxResult = [];
							regExp.customReplace(value, function (e) {
							auxResult.push(	e.matched(0) );
							return "";
							});
							
							new_element.set("func", Std.string(auxResult.length));
							new_element.addChild(Xml.createPCData(value));
						}
						else 
						{			
							new_element.addChild(Xml.createPCData(value));
						}
					}
					
					if(spaces > 0){
						levels[indents-1].addChild(new_element);
					}else{
						root.addChild(new_element);
					}
			
					levels[indents] = new_element;
					
				}			
/*				trace(levels);*/
			}
			
		}
		
		super(x.firstElement());
		
	}
	
	public inline function get( s:String ):String
	{
	  var f:Fast = this;
	  var value = "";
	  var address = s.split(".");
	  for(v in address){
	    if(f.hasNode.resolve(v)){
	      f = f.node.resolve(v);
	    }else if(StringTools.startsWith(v,"@") && f.has.resolve(v.substr(1))){ // @attribute
	      value = f.att.resolve(v);
      }else if(f.has.resolve("yaml-alias") && anchors.exists(f.att.resolve("yaml-alias"))){ // alias?
        var clonee = anchors.get(f.att.resolve("yaml-alias"));
        f = new Fast(clonee).node.resolve(v);
	    }else if(v.indexOf("[") > 0 && v.indexOf("]") > 0){ // array accessor for lists
	      var index = Std.parseInt(v.substr(v.indexOf("[")+1,v.indexOf("]")));
	      var list = f.node.resolve(v.substr(0,v.indexOf("["))).nodes.resolve("_");
        if(list.length > index){
          var i = 0;
          for(item in list){
            if(i == index){
              f = item;
            }else{ i++; }
          }
        }else{
          throw "YamlHX.get() error, node list '"+v+"' index '"+index+"' out of bounds in '"+f.name+"'";
        }
	    }else{
	      throw "YamlHX.get() error, '"+v+"' not found in '"+f.name+"'";
	    }
	  }
	  if(value != ""){
	    return value;
	  }else{
	    return f.innerData;
    }
	}
	
	private static inline function tabsToSpaces( s:String, colon:Int ):String
	{
		if(colon < 0){
			return StringTools.replace(s.substr(0),"\t"," ") + LINE_SEPARATOR;
		}else{
			return StringTools.replace(s.substr(0,colon),"\t"," ") + s.substr(colon) + LINE_SEPARATOR;
		}
		
	}
	
	private static inline function countSpaces( s:String ):Int
	{
		var spaces = 0;
		while(StringTools.isSpace(s,spaces)){
			spaces++;
		}
		return spaces;
	}

	public static function read(input:String):YamlHX
	{
#if cpp
	  #error
	  // # build errors, fork me if you want to help https://github.com/theRemix/yaml-hx
#end
		var yamls = new YamlHX(input);
		return yamls;
	}
	
}