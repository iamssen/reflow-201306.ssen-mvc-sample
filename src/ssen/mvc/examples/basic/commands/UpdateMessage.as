package ssen.mvc.examples.basic.commands {
import ssen.common.IAsyncUnit;
import ssen.mvc.ICommand;
import ssen.mvc.ICommandChain;
import ssen.mvc.IEventBus;
import ssen.mvc.examples.basic.events.MessageErrorEvent;
import ssen.mvc.examples.basic.events.MessageEvent;
import ssen.mvc.examples.basic.models.Message;
import ssen.mvc.examples.basic.services.IMessageService;

public class UpdateMessage implements ICommand {
	//=========================================================
	// inject dependent
	//=========================================================
	[Inject]
	public var service:IMessageService;

	[Inject]
	public var eventBus:IEventBus;

	//=========================================================
	// execute
	//=========================================================
	public function execute(chain:ICommandChain=null):void {
		var evt:MessageEvent=chain.trigger as MessageEvent;
		var unit:IAsyncUnit=service.updateMessage(evt.messageId, evt.text);

		unit.result=function(message:Message):void {
			evt=new MessageEvent(MessageEvent.UPDATED_MESSAGE);
			evt.message=message;
			eventBus.dispatchEvent(evt);
		};

		unit.fault=function(error:Error):void {
			eventBus.dispatchEvent(new MessageErrorEvent(MessageErrorEvent.UPDATE_FAILED));
		};
	}

	public function dispose():void {
		service=null;
		eventBus=null;
	}


}
}
