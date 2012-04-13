package primevc.locale;

import primevc.core.dispatcher.Signal0;
import primevc.locale.LangMacro;


/**
 * ...
 * @author EzeQL
 */

@:build(primevc.locale.LangMacro.build())class LangMan
{
	public var current(default, null):ILang;
	public var changed(default, null):Signal0;
	public var langBind(default, null):LangManBinds;
	
	public function new()
	{
		changed = new Signal0();
		langBind = new LangManBinds();
	
	}
}
