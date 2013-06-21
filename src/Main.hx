package ;
 import flash.display.StageAlign;
 import flash.display.StageScaleMode;
 import flash.Lib;

/**
 * ...
 * @author EzeQL
 */

class Main 
{
	static function main() 
	{
		new Todo();
	}
}

class Todo
{
	public function new ()
	{
		var stage = Lib.current.stage;
		stage.scaleMode = StageScaleMode.NO_SCALE;
		stage.align = StageAlign.TOP_LEFT;
        var f = new prime.examples.todoapp.TodoFacade();
		f.start();
	}
}