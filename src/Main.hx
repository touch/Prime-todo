package ;

import com.ezeql.primevc.examples.todoapp.TodoFacade;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.Lib;
import primevc.core.dispatcher.Signal0;
import primevc.locale.ILang;
import primevc.locale.LangMan;

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

		var f = new TodoFacade();
		f.start();
	
		
	}

}