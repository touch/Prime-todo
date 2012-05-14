package com.ezeql.primevc.examples.todoapp;



import primevc.core.traits.IDisposable;
import primevc.locale.LangMan;
import primevc.mvc.Facade;

/**
 * ...
 * @author EzeQL
 */

class TodoFacade extends Facade < TodoEvents, TodoModel, IDisposable, TodoController, TodoAppView >
{
	public function new() 
	{
		
		LangMan.instance.change.observe(this, test);
		LangMan.instance.NlNL();
		
		//LangMan.instance.bindables.g1.g2.g3.test1.change.bind(this, function(a, b) { trace(a); } );
		
		trace(LangMan.instance.current.describe(1, 2, 3));
		super();
		
	}
	
	private function test() 
	{
		var taxValue = .1;
		var price = 15.25;
		var tax = price * taxValue;
		
		
	}
	
	override private function setupModel ()			{ model			= new TodoModel(); } 
    override private function setupEvents ()		{ events		= new TodoEvents(); } 
    override private function setupView ()			{ view			= new TodoAppView(this); }
    override private function setupController ()	{ controller	= new TodoController(this); }
}