package com.ezeql.primevc.examples.todoapp;
import primevc.core.collections.ArrayList;
import primevc.core.geom.space.Direction;
import primevc.core.geom.space.Horizontal;
import primevc.core.geom.space.Vertical;
import primevc.gui.core.UIElementFlags;
import primevc.gui.layout.algorithms.circle.HorizontalCircleAlgorithm;
import primevc.gui.layout.algorithms.circle.VerticalCircleAlgorithm;
import primevc.gui.layout.algorithms.float.HorizontalFloatAlgorithm;
import primevc.gui.layout.algorithms.ILayoutAlgorithm;
import primevc.gui.layout.algorithms.LayoutAlgorithmBase;
import primevc.gui.layout.algorithms.tile.SimpleTileAlgorithm;

import primevc.locale.LangMan;

using primevc.utils.Bind;
using Std;
/**
 * ...
 * @author EzeQL
 */

class TodoGUIMediator extends primevc.mvc.Mediator<TodoFacade,TodoGUI>
{

    private var algos:Array<ILayoutAlgorithm >;
	override public function startListening ()
    {
        if (isListening())
            return;
		
        super.startListening();
        var input = gui.input;
        input.updateVO = function() { if ( input.vo.value != input.data.value) input.vo.value = input.data.value; };
		addTask.on(gui.btnAddTask.userEvents.mouse.click, this);
		gui.openTasks.data.bind( f.model.todoProxy.openTasks);
        
        
        addRandomTasks.on(gui.addRandomTasksBtn.userEvents.mouse.click, this);
        changeLayout.on(gui.changeLayout.userEvents.mouse.click, this);
        
        LangMan.instance.EnUS.on(gui.englishBtn.userEvents.mouse.click, this);
		LangMan.instance.NlNL.on(gui.dutchBtn.userEvents.mouse.click, this);
		LangMan.instance.EsAR.on(gui.spanishBtn.userEvents.mouse.click, this);
		LangMan.instance.RuRU.on(gui.russianBtn.userEvents.mouse.click, this);
        
        algos = new Array<ILayoutAlgorithm>();
        algos.push(gui.listView.layoutContainer.algorithm);
        algos.push(new HorizontalFloatAlgorithm(Horizontal.left, Vertical.top));
        //algos.push(new HorizontalCircleAlgorithm(Horizontal.center, Vertical.center,false));
        algos.push(new SimpleTileAlgorithm(Direction.horizontal));
        algos.push(new SimpleTileAlgorithm(Direction.vertical));
	}
    
    private function addRandomTasks() 
    {
        for (i in 0...20)
        {
            var randomStr = guid();
            f.model.todoProxy.vo.add(randomStr);
        }
        
    }
    
    private inline function guid()
    {
        var n = "rnd" + Math.floor(Math.random() * 0x10000);
        
        return n.string();
    }
    

    private function changeLayout() 
    {
        algos.push(algos.shift());
        gui.listView.layoutContainer.algorithm = algos[0];
    }
    
	private function addTask()
	{
        var value = gui.input.vo.value;
		if ( value != null && value != "")
		{
            if (f.model.todoProxy.vo.indexOf(value) == -1)
            {
                f.model.todoProxy.vo.add(gui.input.vo.value);
                gui.input.vo.value = null;
            }
            else
            {
                //TODO: show duplicated?
            }
        }
	}
}