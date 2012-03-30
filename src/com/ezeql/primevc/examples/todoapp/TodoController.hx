package com.ezeql.primevc.examples.todoapp;
import primevc.mvc.IMVCCoreActor;
import primevc.mvc.MVCActor;

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