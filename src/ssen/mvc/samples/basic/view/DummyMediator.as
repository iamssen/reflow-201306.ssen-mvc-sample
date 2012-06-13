package ssen.mvc.samples.basic.view {
	import flash.events.Event;

	import spark.components.TextArea;

	import ssen.mvc.core.IContextDispatcher;
	import ssen.mvc.core.IMediator;
	import ssen.mvc.samples.basic.events.MessageErrorEvent;
	import ssen.mvc.samples.basic.events.MessageUIEvent;
	import ssen.mvc.samples.basic.events.MessageUIOrder;

	public class DummyMediator implements IMediator {
		[Inject]
		public var dispatcher:IContextDispatcher;

		private var view:Dummy;

		public function setView(view:Object):void {
			this.view=view as Dummy;
		}

		public function onRemove():void {
			dispatcher.removeEventListener(MessageUIEvent.ADD_MESSAGE, viewEvent);
			dispatcher.removeEventListener(MessageUIOrder.CREATED_NEW_MESSAGE, viewEvent);
			dispatcher.removeEventListener(MessageUIOrder.TEXT_IS_BLANK, viewEvent);
			dispatcher.removeEventListener(MessageErrorEvent.ADDED_FAILED, viewEvent);
		}

		public function onRegister():void {
			dispatcher.addEventListener(MessageUIEvent.ADD_MESSAGE, viewEvent);
			dispatcher.addEventListener(MessageUIOrder.CREATED_NEW_MESSAGE, viewEvent);
			dispatcher.addEventListener(MessageUIOrder.TEXT_IS_BLANK, viewEvent);
			dispatcher.addEventListener(MessageErrorEvent.ADDED_FAILED, viewEvent);
		}

		private function viewEvent(event:Event):void {
			trace("DummyMediator.viewEvent", event);
			view.log(event.toString());
		}
	}
}
