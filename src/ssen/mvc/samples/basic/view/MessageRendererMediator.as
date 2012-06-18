package ssen.mvc.samples.basic.view {
	import flash.events.Event;
	
	import ssen.mvc.core.IContextDispatcher;
	import ssen.mvc.core.IMediator;
	import ssen.mvc.samples.basic.events.MessageEvent;

	public class MessageRendererMediator implements IMediator {
		[Inject]
		public var dispatcher:IContextDispatcher;

		private var view:MessageRenderer;

		public function setView(view:Object):void {
			this.view=view as MessageRenderer;
		}

		public function onRegister():void {
			view.addEventListener(view.REMOVE, removeHandler);
			view.addEventListener(view.UPDATE, updateHandler);
		}

		public function onRemove():void {
			view.removeEventListener(view.REMOVE, removeHandler);
			view.removeEventListener(view.UPDATE, updateHandler);
			view=null;
		}

		private function updateHandler(event:Event):void {
			var evt:MessageEvent=new MessageEvent(MessageEvent.REMOVE_MESSAGE);
			evt.messageId=view.getId();

			dispatcher.dispatch(evt);
		}

		private function removeHandler(event:Event):void {
			var evt:MessageEvent=new MessageEvent(MessageEvent.REMOVE_MESSAGE);
			evt.messageId=view.getId();

			dispatcher.dispatch(evt);
		}
	}
}
