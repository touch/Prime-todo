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
		TodoFacade.langMan.ruRU();
		
		TodoFacade.langMan.changed.observe( this, test) ;

		
		
		
		super();
	}
	
	private function test() 
	{
		trace( TodoFacade.langMan.current.comments(0) );
		trace( TodoFacade.langMan.current.comments(1) );
		trace( TodoFacade.langMan.current.comments(2) );
		trace( TodoFacade.langMan.current.comments(6) );
		trace( TodoFacade.langMan.current.comments(10) );
	}
	
	override private function setupModel ()			{ model			= new TodoModel(); } 
    override private function setupEvents ()		{ events		= new TodoEvents(); } 
    override private function setupView ()			{ view			= new TodoAppView(this); }
    override private function setupController ()	{ controller	= new TodoController(this); }
}