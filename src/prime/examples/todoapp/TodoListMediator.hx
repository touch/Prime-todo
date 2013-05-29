package prime.examples.todoapp;
 import prime.gui.components.Button;
 import prime.gui.components.DataButton;
 import prime.gui.events.MouseEvents;


/**
 * ...
 * @author EzeQL
 */

class TodoListMediator extends prime.mvc.Mediator<TodoFacade,TodoList>
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