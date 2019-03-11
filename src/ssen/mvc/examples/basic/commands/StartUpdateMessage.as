package ssen.mvc.examples.basic.commands {
import flash.display.DisplayObject;

import mx.managers.PopUpManager;

import ssen.mvc.ICommand;
import ssen.mvc.ICommandChain;
import ssen.mvc.IContextView;
import ssen.mvc.examples.basic.events.MessageEvent;
import ssen.mvc.examples.basic.views.MessageUpdate;

public class StartUpdateMessage implements ICommand {
	//==========================================================================================
	// inject dependent
	//==========================================================================================
	[Inject]
	public var contextView:IContextView;

	//==========================================================================================
	// execute
	//==========================================================================================
	public function execute(chain:ICommandChain=null):void {
		var evt:MessageEvent=chain.trigger as MessageEvent;

		var view:MessageUpdate=new MessageUpdate;
		view.targetMessageId=evt.messageId;

		PopUpManager.addPopUp(view, contextView as DisplayObject, true);
		PopUpManager.centerPopUp(view);
	}

	public function dispose():void {
		contextView=null;
	}
}
}
