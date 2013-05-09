package com.ezeql.primevc.examples.todoapp;

import primevc.mvc.IMVCCore;
import primevc.mvc.MVCNotifier;

/**
 * ...
 * @author EzeQL
 */

class TodoModel extends MVCNotifier, implements IMVCCore
{
	public var todoProxy(default, null):TodoProxy;

	public function init(events)
	{
		todoProxy = new TodoProxy(events);
	}
}