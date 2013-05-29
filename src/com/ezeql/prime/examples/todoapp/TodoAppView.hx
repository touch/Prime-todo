package com.ezeql.prime.examples.todoapp;
 import com.ezeql.prime.examples.todoapp.TodoGUIMediator;
 import flash.Lib;
 import prime.mvc.IMVCCoreActor;
 import prime.mvc.MVCActor;

/**
 * ...
 * @author EzeQL
 */

class TodoAppView extends MVCActor<TodoFacade>, implements IMVCCoreActor
{
	public var todoListMediator:TodoListMediator;
	public var todoGUIMediator:TodoGUIMediator;

	public function new(facade) 
	{
		super(facade);
		var gui = new TodoGUI(Lib.current.stage, "todoGUI");
		
		todoGUIMediator = new TodoGUIMediator(facade, true, gui);
		todoListMediator = new TodoListMediator(facade, true, gui.listView); 
	}
}