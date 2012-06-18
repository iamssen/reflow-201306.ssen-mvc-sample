package ssen.mvc.samples.basic.view {
	import flash.events.Event;
	
	import ssen.mvc.core.IContextDispatcher;
	import ssen.mvc.core.IMediator;
	import ssen.mvc.samples.basic.events.MessageErrorEvent;
	import ssen.mvc.samples.basic.events.MessageEvent;

	public class DummyMediator implements IMediator {
		[Inject]
		public var dispatcher:IContextDispatcher;

		private var view:Dummy;

		public function setView(view:Object):void {
			this.view=view as Dummy;
		}

		public function onRemove():void {
			dispatcher.removeEventListener(MessageEvent.ADD_MESSAGE, viewEvent);
			dispatcher.removeEventListener(MessageEvent.REMOVE_MESSAGE, viewEvent);
			dispatcher.removeEventListener(MessageEvent.REMOVED_MESSAGE, viewEvent);
			dispatcher.removeEventListener(MessageEvent.ADDED_MESSAGE, viewEvent);
			dispatcher.removeEventListener(MessageErrorEvent.TEXT_IS_BLANK, viewEvent);
			dispatcher.removeEventListener(MessageErrorEvent.ADD_FAILED, viewEvent);
			dispatcher.removeEventListener(MessageErrorEvent.REMOVE_FAILED, viewEvent);
		}

		public function onRegister():void {
			dispatcher.addEventListener(MessageEvent.ADD_MESSAGE, viewEvent);
			dispatcher.addEventListener(MessageEvent.REMOVE_MESSAGE, viewEvent);
			dispatcher.addEventListener(MessageEvent.REMOVED_MESSAGE, viewEvent);
			dispatcher.addEventListener(MessageEvent.ADDED_MESSAGE, viewEvent);
			dispatcher.addEventListener(MessageErrorEvent.TEXT_IS_BLANK, viewEvent);
			dispatcher.addEventListener(MessageErrorEvent.ADD_FAILED, viewEvent);
			dispatcher.addEventListener(MessageErrorEvent.REMOVE_FAILED, viewEvent);
		}

		private function viewEvent(event:Event):void {
			trace("DummyMediator.viewEvent", event);
			view.log(event.toString());
		}
	}
}
