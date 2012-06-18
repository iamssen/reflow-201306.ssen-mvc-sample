package ssen.mvc.samples.basic.view {
	import flash.events.Event;

	import ssen.mvc.core.IContextDispatcher;
	import ssen.mvc.core.IMediator;
	import ssen.mvc.samples.basic.events.MessageErrorEvent;
	import ssen.mvc.samples.basic.events.MessageEvent;

	public class MessageUpdateMediator implements IMediator {
		[Inject]
		public var dispatcher:IContextDispatcher;

		private var view:MessageUpdate;

		public function setView(view:Object):void {
			this.view=view as MessageUpdate;
		}

		public function onRegister():void {
			dispatcher.addEventListener(MessageEvent.UPDATED_MESSAGE, updatedMessage);
			dispatcher.addEventListener(MessageErrorEvent.UPDATE_FAILED, updateFailed);
			view.addEventListener(view.SUBMIT, submitHandler);
		}

		public function onRemove():void {
			dispatcher.removeEventListener(MessageEvent.UPDATED_MESSAGE, updatedMessage);
			dispatcher.removeEventListener(MessageErrorEvent.UPDATE_FAILED, updateFailed);
			view.removeEventListener(view.SUBMIT, submitHandler);
			view.deconstruct();
			view=null;
		}

		private function submitHandler(event:Event):void {
			var str:String=view.getText();
			
			if (str === "") {
				dispatcher.dispatch(new MessageErrorEvent(MessageErrorEvent.TEXT_IS_BLANK));
				return;
			}
			
			view.enabled=false;
			
			var evt:MessageEvent=new MessageEvent(MessageEvent.UPDATE_MESSAGE);
			evt.messageId;
			evt.text=str;
			
			dispatcher.dispatch(evt);
		}

		private function updateFailed(event:MessageErrorEvent):void {
			// TODO Auto Generated method stub

		}

		private function updatedMessage(event:MessageEvent):void {
			// TODO Auto Generated method stub

		}
	}
}
