package prime.examples.todoapp;
 import prime.bindable.Bindable;
 import prime.gui.components.DataButton;
 import prime.gui.components.Label;
 import prime.gui.core.UIDataContainer;

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

		btnDelete = new DataButton<String>("b" + this.id,"delete task");
		btnDelete.name = data.value;
		attach(btnDelete);
		
	}
}