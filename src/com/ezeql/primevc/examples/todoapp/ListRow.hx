package com.ezeql.primevc.examples.todoapp;
import primevc.core.Bindable;
import primevc.gui.components.Button;
import primevc.gui.components.DataButton;
import primevc.gui.components.Label;
import primevc.gui.core.UIDataContainer;

using primevc.utils.Bind;

/**
 * ...
 * @author EzeQL
 */
private typedef DataType	= Bindable<String>;
class ListRow extends UIDataContainer <DataType> 
{
	private var lblTask:Label;
	private var btnDelete:DataButton<String>;

	public function new(id:String,task:String)
	{
		super(id, new DataType(task));
		
	}
	
	override function createChildren()
	{
		lblTask = new Label("label" + this.id, new Bindable<String>(data.value) );
		attach(lblTask);
		
		btnDelete = new DataButton<String>("b" + this.id, TodoFacade.langMan.bindables.removetask.value, null);
		btnDelete.data = TodoFacade.langMan.bindables.removetask;
		attach(btnDelete);
		btnDelete.name = data.value;
		
	}
	
	
}