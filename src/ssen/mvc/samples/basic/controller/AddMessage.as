package ssen.mvc.samples.basic.controller {
	import flash.events.Event;

	import ssen.mvc.core.ICommand;
	import ssen.mvc.core.IContextDispatcher;
	import ssen.mvc.samples.basic.events.MessageErrorEvent;
	import ssen.mvc.samples.basic.events.MessageUIEvent;
	import ssen.mvc.samples.basic.events.MessageUIOrder;
	import ssen.mvc.samples.basic.model.Message;
	import ssen.mvc.samples.basic.model.MessageModel;

	public class AddMessage implements ICommand {

		[Inject]
		public var model:MessageModel;

		[Inject]
		public var dispatcher:IContextDispatcher;

		public function execute(event:Event=null):void {
			var uiEvent:MessageUIEvent=event as MessageUIEvent;
			var uiOrder:MessageUIOrder;
			var errorEvent:MessageErrorEvent;

			model.addMessage(uiEvent.message, function(message:Message):void {
				uiOrder=new MessageUIOrder(MessageUIOrder.CREATED_NEW_MESSAGE);
				uiOrder.messageId=message.id;
				dispatcher.dispatch(uiOrder);
			}, function(error:Error):void {
				errorEvent=new MessageErrorEvent(MessageErrorEvent.ADDED_FAILED, error.message,
												 error.errorID);
				dispatcher.dispatch(errorEvent);
			});
		}
	}
}
