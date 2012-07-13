package ssen.mvc.samples.basic.view {
	import flash.events.Event;
	
	import ssen.mvc.core.IEventBus;
	import ssen.mvc.core.IMediator;
	import ssen.mvc.samples.basic.events.MessageErrorEvent;
	import ssen.mvc.samples.basic.events.MessageEvent;

	public class DummyMediator implements IMediator {
		[Inject]
		public var eventBus:IEventBus;

		private var view:Dummy;

		public function setView(view:Object):void {
			this.view=view as Dummy;
		}

		public function onRemove():void {
			eventBus.removeEventListener(MessageEvent.ADD_MESSAGE, viewEvent);
			eventBus.removeEventListener(MessageEvent.ADDED_MESSAGE, viewEvent);
			eventBus.removeEventListener(MessageEvent.REMOVE_MESSAGE, viewEvent);
			eventBus.removeEventListener(MessageEvent.REMOVED_MESSAGE, viewEvent);
			eventBus.removeEventListener(MessageEvent.UPDATE_MESSAGE, viewEvent);
			eventBus.removeEventListener(MessageEvent.UPDATED_MESSAGE, viewEvent);
			eventBus.removeEventListener(MessageEvent.START_UPDATE, viewEvent);
			
			eventBus.removeEventListener(MessageErrorEvent.TEXT_IS_BLANK, viewEvent);
			eventBus.removeEventListener(MessageErrorEvent.ADD_FAILED, viewEvent);
			eventBus.removeEventListener(MessageErrorEvent.REMOVE_FAILED, viewEvent);
		}

		public function onRegister():void {
			eventBus.addEventListener(MessageEvent.ADD_MESSAGE, viewEvent);
			eventBus.addEventListener(MessageEvent.ADDED_MESSAGE, viewEvent);
			eventBus.addEventListener(MessageEvent.REMOVE_MESSAGE, viewEvent);
			eventBus.addEventListener(MessageEvent.REMOVED_MESSAGE, viewEvent);
			eventBus.addEventListener(MessageEvent.UPDATE_MESSAGE, viewEvent);
			eventBus.addEventListener(MessageEvent.UPDATED_MESSAGE, viewEvent);
			eventBus.addEventListener(MessageEvent.START_UPDATE, viewEvent);

			eventBus.addEventListener(MessageErrorEvent.TEXT_IS_BLANK, viewEvent);
			eventBus.addEventListener(MessageErrorEvent.ADD_FAILED, viewEvent);
			eventBus.addEventListener(MessageErrorEvent.REMOVE_FAILED, viewEvent);
		}

		private function viewEvent(event:Event):void {
			trace("DummyMediator.viewEvent", event);
			view.log(event.toString());
		}
	}
}
