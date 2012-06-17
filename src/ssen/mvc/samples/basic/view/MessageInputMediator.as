package ssen.mvc.samples.basic.view {
	import flash.events.Event;
	
	import ssen.mvc.core.IContextDispatcher;
	import ssen.mvc.core.IMediator;
	import ssen.mvc.samples.basic.events.MessageErrorEvent;
	import ssen.mvc.samples.basic.events.MessageEvent;

	public class MessageInputMediator implements IMediator {
		[Inject]
		public var dispatcher:IContextDispatcher;

		private var view:MessageInput;

		public function setView(view:Object):void {
			this.view=view as MessageInput;
		}

		public function onRemove():void {
			dispatcher.removeEventListener(MessageEvent.ADDED_MESSAGE, createdNewMessage);
			view.removeEventListener(view.SUBMIT, submitHandler);
			view.deconstruct();
			view=null;
		}

		public function onRegister():void {
			dispatcher.addEventListener(MessageEvent.ADDED_MESSAGE, createdNewMessage);
			dispatcher.addEventListener(MessageErrorEvent.ADD_FAILED, addMessageFailed);
			view.addEventListener(view.SUBMIT, submitHandler);
		}

		private function addMessageFailed(event:MessageErrorEvent):void {
			view.enabled=true;
		}

		private function createdNewMessage(event:MessageEvent):void {
			view.enabled=true;

			view.clearText();
		}

		private function submitHandler(event:Event):void {
			var str:String=view.getText();

			if (str === "") {
				dispatcher.dispatch(new MessageEvent(MessageEvent.TEXT_IS_BLANK));
				return;
			}

			view.enabled=false;

			var evt:MessageEvent=new MessageEvent(MessageEvent.ADD_MESSAGE);
			evt.text=str;

			dispatcher.dispatch(evt);
		}
	}
}
