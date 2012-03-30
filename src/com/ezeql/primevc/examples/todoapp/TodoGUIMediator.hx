package com.ezeql.primevc.examples.todoapp;
import primevc.core.collections.ArrayList;
import primevc.gui.core.UIElementFlags;

using primevc.utils.Bind;
/**
 * ...
 * @author EzeQL
 */

class TodoGUIMediator extends primevc.mvc.Mediator<TodoFacade,TodoGUI>
{

	override public function startListening ()
    {
        if (isListening())
            return;
		
        super.startListening();
		
		addTask.on(gui.btnAccept.userEvents.mouse.click, this);
		gui.openTasks.data.bind( f.model.todoProxy.openTasks);
	}
	
	private function addTask()
	{
		if ( gui.input.vo.value != "")
		{
			f.model.todoProxy.vo.add( gui.input.vo.value);
			gui.input.vo.value = "";
		}
	}
}