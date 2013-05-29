package com.ezeql.prime.examples.todoapp;
 import prime.bindable.Bindable;
 import prime.bindable.collections.ArrayList;
 import prime.locale.LangMan;
 import prime.mvc.Proxy;
 import prime.utils.FastArray;
  using prime.utils.Bind;
  using Std;

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