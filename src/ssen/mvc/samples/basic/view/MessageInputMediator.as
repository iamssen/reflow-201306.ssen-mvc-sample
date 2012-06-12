package ssen.mvc.samples.basic.view {
	import flash.events.Event;

	import ssen.mvc.core.IContextDispatcher;
	import ssen.mvc.core.IMediator;
	import ssen.mvc.samples.basic.model.MessageEvent;

	public class MessageInputMediator implements IMediator {
		[Inject]
		public var dispatcher:IContextDispatcher;

		private var view:MessageInput;

		public function setView(view:Object):void {
			this.view=view as MessageInput;
		}

		public function onRegister():void {
			view.addEventListener(view.SUBMIT, submitHandler);
		}

		private function submitHandler(event:Event):void {
			var evt:MessageEvent=new MessageEvent;
			evt.message=view.getText();

			dispatcher.dispatch(evt);
		}

		public function onRemove():void {
			view.removeEventListener(view.SUBMIT, submitHandler);
			view.deconstruct();
			view=null;
		}
	}
}
