package prime.examples.todoapp;
 import prime.gui.core.IUIDataElement;

/**
 * ...
 * @author EzeQL
 */

class TodoList extends prime.gui.components.ListView<String>
{

	public function new(id:String = null ) 
	{
		super(id);
		this.createItemRenderer =   function (a, b):IUIDataElement<String> { 
                                        return cast new ListRow("listRow" + Std.string(b), a); 
                                    };
	}
	
}