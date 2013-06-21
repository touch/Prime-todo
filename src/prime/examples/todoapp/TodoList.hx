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
		this.createItemRenderer =   function (id, task):IUIDataElement<String> { 
                                        return cast new ListRow("listRow" + Std.string(task), id);                                     };
	}
	
}