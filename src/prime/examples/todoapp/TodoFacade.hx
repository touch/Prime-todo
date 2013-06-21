package prime.examples.todoapp;

 import prime.core.traits.IDisposable;
 import prime.mvc.Facade;

/**
 * ...
 * @author EzeQL
 */

class TodoFacade extends Facade < TodoEvents, TodoModel, IDisposable, TodoController, TodoAppView >
{
	public function new() 
	{
		super();
	}

	override private function setupModel ()			{ model			= new TodoModel(); } 
    override private function setupEvents ()		{ events		= new TodoEvents(); } 
    override private function setupView ()			{ view			= new TodoAppView(this); }
    override private function setupController ()	{ controller	= new TodoController(this); }
}