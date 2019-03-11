package ssen.mvc.examples.basic.commands {
import ssen.common.IAsyncUnit;
import ssen.mvc.ICommand;
import ssen.mvc.ICommandChain;
import ssen.mvc.IEventBus;
import ssen.mvc.examples.basic.events.MessageErrorEvent;
import ssen.mvc.examples.basic.events.MessageEvent;
import ssen.mvc.examples.basic.models.Message;
import ssen.mvc.examples.basic.models.MessageModel;
import ssen.mvc.examples.basic.services.IMessageService;

public class AddMessage implements ICommand {
	//=========================================================
	// inject dependent
	//=========================================================
	[Inject]
	public var service:IMessageService;

	[Inject]
	public var eventBus:IEventBus;

	[Inject]
	public var model:MessageModel;

	//=========================================================
	// execute
	//=========================================================
	public function execute(chain:ICommandChain=null):void {
		var evt:MessageEvent=chain.trigger as MessageEvent;
		var unit:IAsyncUnit=service.addMessage(evt.text);

		unit.result=function(message:Message):void {
			model.added(message);
			chain.next();
		};

		unit.fault=function(error:Error):void {
			eventBus.dispatchEvent(new MessageErrorEvent(MessageErrorEvent.ADD_FAILED));
			chain.next();
		};
	}

	public function dispose():void {
		service=null;
		eventBus=null;
		model=null;
	}
}
}
