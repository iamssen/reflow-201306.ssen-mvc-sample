package ssen.mvc.samples.basic.view {
	import flash.events.Event;

	import ssen.mvc.core.IContextDispatcher;
	import ssen.mvc.core.IMediator;
	import ssen.mvc.samples.basic.events.MessageErrorEvent;
	import ssen.mvc.samples.basic.events.MessageUIEvent;
	import ssen.mvc.samples.basic.events.MessageUIOrder;

	public class MessageInputMediator implements IMediator {
		[Inject]
		public var dispatcher:IContextDispatcher;

		private var view:MessageInput;

		public function setView(view:Object):void {
			this.view=view as MessageInput;
		}

		public function onRemove():void {
			dispatcher.removeEventListener(MessageUIOrder.CREATED_NEW_MESSAGE, createdNewMessage);
			view.removeEventListener(view.SUBMIT, submitHandler);
			view.deconstruct();
			view=null;
		}

		public function onRegister():void {
			dispatcher.addEventListener(MessageUIOrder.CREATED_NEW_MESSAGE, createdNewMessage);
			dispatcher.addEventListener(MessageErrorEvent.ADDED_FAILED, addMessageFailed);
			view.addEventListener(view.SUBMIT, submitHandler);
		}

		private function addMessageFailed(event:MessageErrorEvent):void {
			view.enabled=true;
		}

		private function createdNewMessage(event:MessageUIOrder):void {
			view.enabled=true;

			view.clearText();
		}

		private function submitHandler(event:Event):void {
			var str:String=view.getText();

			if (str === "") {
				dispatcher.dispatch(new MessageUIOrder(MessageUIOrder.TEXT_IS_BLANK));
				return;
			}

			view.enabled=false;

			var evt:MessageUIEvent=new MessageUIEvent(MessageUIEvent.ADD_MESSAGE);
			evt.message=str;

			dispatcher.dispatch(evt);
		}
	}
}
