package com.ezeql.primevc.examples.todoapp;

import primevc.gui.components.Button;
import primevc.gui.components.DataButton;
import primevc.gui.events.MouseEvents;


/**
 * ...
 * @author EzeQL
 */

class TodoListMediator extends primevc.mvc.Mediator<TodoFacade,TodoList>
{

	override public function startListening ()
    {
        if (isListening())
            return;
		
        super.startListening();

		gui.data = f.model.todoProxy.vo;
		gui.childClick.bind(this, handler);
	}
	
	private function handler(e:MouseState) 
	{
		f.model.todoProxy.vo.remove(e.target.name);
	}
}