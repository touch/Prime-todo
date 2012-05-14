package com.ezeql.primevc.examples.todoapp;
import primevc.core.Bindable;
import primevc.core.collections.ArrayList;
import primevc.locale.LangMan;
import primevc.mvc.Proxy;
import primevc.utils.FastArray;

using primevc.utils.Bind;
using Std;

/**
/**
 * ...
 * @author EzeQL
 */

class TodoProxy extends Proxy < ArrayList<String>, TodoEvents > 
{
	public var openTasks(default, null):Bindable<String>;

	public function new(events) 
	{
		super(events);
		vo = new ArrayList<String>();
		openTasks = new Bindable<String>();
		updateOpenTaks();
		updateOpenTaks.on(vo.change, this);
		updateOpenTaks.on(LangMan.instance.bindables.opentasks.change, this);
	}
	
	private function updateOpenTaks() 
	{
		openTasks.value = LangMan.instance.bindables.opentasks.value + ":" + vo.length.string();
		
		
	}
	
}