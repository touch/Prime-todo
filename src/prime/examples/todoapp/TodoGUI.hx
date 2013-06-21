package prime.examples.todoapp;
 import prime.bindable.Bindable;
 import prime.gui.components.Button;
 import prime.gui.components.Form;
 import prime.gui.components.InputField;
 import prime.gui.components.Label;
 import prime.gui.core.UIContainer;
 import prime.gui.core.UITextField;
 import prime.gui.core.UIWindow;
  using prime.utils.Bind;

 /**
 * ...
 * @author EzeQL
 */

class TodoGUI extends UIWindow
{
    
	public var title:UITextField;
	public var listView:TodoList;
	public var input:InputField<String>;
    public var addRandomTasksBtn:Button;
	public var btnAddTask:Button;
	public var openTasks:Label;
    public var changeLayout:Button;
    public var optionsHolder:UIContainer;

	override private function createChildren():Void 
	{
		super.createChildren();
		title = new UITextField("title", true, new Bindable<String>("prime ToDo"));
		attach(title);
	
		input = new InputField("input", "I'll...");
		attach(input);
		
		btnAddTask = new Button("btnAddTask","add task");
        
        addRandomTasksBtn = new Button("addRandom", "randomData");
        
        var virtual = Form.createHorizontalRow();
        virtual.attach(btnAddTask.layout);
        virtual.attach(addRandomTasksBtn.layout);
        virtual.attachTo(this.layoutContainer);
        attachDisplay(btnAddTask);
        attachDisplay(addRandomTasksBtn);
        
		attach(listView = new TodoList("listView"));
		
        optionsHolder = new UIContainer("optionsHolder");

   		openTasks = new Label("openTasks");

        var layoutsLbl = new Label("layoutsLbl", new Bindable<String>("change layout"));
        changeLayout   = new Button("changeLayout","change layout");
        
		optionsHolder.attach(changeLayout).attach(openTasks);
        
        attach(optionsHolder);
	}
}