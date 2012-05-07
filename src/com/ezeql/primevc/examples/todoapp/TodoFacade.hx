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
	public static var langMan(default, null):LangMan;

	public function new() 
	{
	
		TodoFacade.langMan = new LangMan();
		TodoFacade.langMan.change.observe(this, test);
		TodoFacade.langMan.EnNZ();
		
		TodoFacade.langMan.bindables.g1.g2.g3.test1.change.bind(this, function(a, b) { trace(a); } );
		
		super();
		
	}
	
	private function test() 
	{
		var taxValue = .1;
		var price = 15.25;
		var tax = price * taxValue;
		
		trace(TodoFacade.langMan.current.test.describe(price, tax, price + tax));
	}
	
	override private function setupModel ()			{ model			= new TodoModel(); } 
    override private function setupEvents ()		{ events		= new TodoEvents(); } 
    override private function setupView ()			{ view			= new TodoAppView(this); }
    override private function setupController ()	{ controller	= new TodoController(this); }
}