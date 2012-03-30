package com.ezeql.primevc.examples.todoapp;
import com.ezeql.primevc.examples.todoapp.TodoGUIMediator;
import flash.Lib;
import primevc.mvc.IMVCCoreActor;
import primevc.mvc.MVCActor;

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