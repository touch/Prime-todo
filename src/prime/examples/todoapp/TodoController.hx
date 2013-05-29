package prime.examples.todoapp;
 import prime.mvc.IMVCCoreActor;
 import prime.mvc.MVCActor;

/**
 * ...
 * @author EzeQL
 */

class TodoController  extends MVCActor<TodoFacade>, implements IMVCCoreActor
{
	public function new(facade) 
	{
		super(facade);
	}

	override function startListening()
	{
		f.model.init(f.events);
	}
}