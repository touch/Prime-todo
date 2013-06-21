package prime.examples.todoapp;
 
/**
 * ...
 * @author EzeQL
 */

class TodoModel extends prime.mvc.MVCNotifier implements prime.mvc.IMVCCore
{
	public var todoProxy(default, null):TodoProxy;

	public function init(events)
	{
		todoProxy = new TodoProxy(events);
	}
}