package prime.examples.todoapp;
 import prime.bindable.Bindable;
 import prime.bindable.collections.ArrayList;
  using prime.utils.Bind;
  using Std;

/**
 * ...
 * @author EzeQL
 */

class TodoProxy extends prime.mvc.Proxy <ArrayList<String>, TodoEvents > 
{
	public var openTasks(default, null):Bindable<String>;

	public function new(events) 
	{
		super(events);
		vo = new ArrayList<String>();
		openTasks = new Bindable<String>();
		updateOpenTaks();
		updateOpenTaks.on(vo.change, this);
	}
	
	private function updateOpenTaks() 
	{
		openTasks.value = "open tasks " + vo.length.string();
	}
}