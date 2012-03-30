package com.ezeql.primevc.examples.todoapp;

//import com.ezeql.calc.views.CalcProxy;
import primevc.mvc.IMVCCore;
import primevc.mvc.MVCNotifier;




/**
 * ...
 * @author EzeQL
 */

class TodoModel extends MVCNotifier, implements IMVCCore
{
	public var todoProxy(default, null):TodoProxy;


	public function new() 
	{
		super();
	}
	
	public function init(events)
	{
		todoProxy = new TodoProxy(events);

	}
	
}