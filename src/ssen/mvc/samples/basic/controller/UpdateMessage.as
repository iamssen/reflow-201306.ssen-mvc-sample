package ssen.mvc.samples.basic.controller {
import flash.events.Event;

import ssen.mvc.core.ICommand;
import ssen.mvc.core.IContextDispatcher;
import ssen.mvc.samples.basic.events.MessageErrorEvent;
import ssen.mvc.samples.basic.events.MessageEvent;
import ssen.mvc.samples.basic.model.Message;
import ssen.mvc.samples.basic.model.MessageModel;

public class UpdateMessage implements ICommand {
	[Inject]
	public var model:MessageModel;

	[Inject]
	public var dispatcher:IContextDispatcher;

	public function execute(event:Event=null):void {
		var inputEvt:MessageEvent=event as MessageEvent;
		var outputEvt:MessageEvent;
		var errorEvt:MessageErrorEvent;

		model.updateMessage(inputEvt.messageId, inputEvt.text, function(message:Message):void {
			outputEvt=new MessageEvent(MessageEvent.UPDATED_MESSAGE);
			outputEvt.messageId=message.id;
			dispatcher.dispatch(outputEvt);
		}, function(error:Error):void {
			errorEvt=new MessageErrorEvent(MessageErrorEvent.UPDATE_FAILED, error.message, error.errorID);
			dispatcher.dispatch(errorEvt);
		});
	}
}
}
