package com.ezeql.primevc.examples.todoapp;
import primevc.gui.core.IUIDataElement;
import primevc.gui.components.ListView;

/**
 * ...
 * @author EzeQL
 */

class TodoList extends ListView<String>
{

	public function new(id) 
	{
		super(id);
		this.createItemRenderer =  function (a, b):IUIDataElement<String> { return cast new ListRow("listRow" + Std.string(b), a); };
		

	}
	
}