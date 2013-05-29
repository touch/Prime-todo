package prime.examples.todoapp;
 import prime.gui.components.Button;
 import prime.gui.components.DataButton;
 import prime.gui.components.Form;
 import prime.gui.components.InputField;
 import prime.gui.components.Label;
 import prime.gui.core.UIContainer;
 import prime.gui.core.UITextField;
 import prime.gui.core.UIWindow;
 import prime.locale.LangMan;
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
    
    public  var optionsHolder:UIContainer;
  	public  var englishBtn:Button;
	public  var spanishBtn:Button;
	public  var dutchBtn:Button;
	public  var russianBtn:Button;
    
	
	override private function createChildren():Void 
	{
		super.createChildren();
        var bindables = LangMan.instance.bindables;
		title = new UITextField("title", true, bindables.apptitle);
		attach(title);
	
		input = new InputField("input", LangMan.instance.current.tasktext);
		attach(input);
		
		btnAddTask = new Button("btnAddTask");
        btnAddTask.data  = bindables.addtask;
        
        addRandomTasksBtn = new Button("addRandom", "randomData");
        
        var virtual = Form.createHorizontalRow();
        virtual.attach(btnAddTask.layout);
        virtual.attach(addRandomTasksBtn.layout);
        virtual.attachTo(this.layoutContainer);
        attachDisplay(btnAddTask);
        attachDisplay(addRandomTasksBtn);
        
		attach(listView = new TodoList("listView"));
		attach(openTasks = new Label("openTasks"));
		
        optionsHolder = new UIContainer("optionsHolder");
        
        var langsLbl = new Label("langsLbl", LangMan.instance.bindables.languages);
		englishBtn = new Button("english", "English");
		dutchBtn   = new Button("dutch"  , "Dutch");
		spanishBtn = new Button("spanish", "Spanish");
		russianBtn = new Button("russian", "Russian");
        
        var layoutsLbl = new Label("layoutsLbl", LangMan.instance.bindables.layouts);
        changeLayout = new Button("changeLayout");
        changeLayout.data  = LangMan.instance.bindables.changeLayout;
        
		optionsHolder.attach(langsLbl).attach(englishBtn).attach(dutchBtn).attach(spanishBtn).attach(russianBtn).attach(layoutsLbl).attach(changeLayout);

        attach(optionsHolder);
	}
}