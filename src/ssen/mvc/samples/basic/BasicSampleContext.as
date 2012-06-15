package ssen.mvc.samples.basic {
	import ssen.mvc.core.IContext;
	import ssen.mvc.core.IContextView;
	import ssen.mvc.ondisplay.DisplayContext;
	import ssen.mvc.samples.basic.controller.AddMessage;
	import ssen.mvc.samples.basic.controller.RemoveMessage;
	import ssen.mvc.samples.basic.events.MessageEvent;
	import ssen.mvc.samples.basic.model.LocalMessageModel;
	import ssen.mvc.samples.basic.model.MessageModel;
	import ssen.mvc.samples.basic.view.Dummy;
	import ssen.mvc.samples.basic.view.DummyMediator;
	import ssen.mvc.samples.basic.view.MessageInput;
	import ssen.mvc.samples.basic.view.MessageInputMediator;
	import ssen.mvc.samples.basic.view.MessageLog;
	import ssen.mvc.samples.basic.view.MessageLogListRenderer;
	import ssen.mvc.samples.basic.view.MessageLogMediator;
	import ssen.mvc.samples.basic.view.MessageRendererMediator;

	public class BasicSampleContext extends DisplayContext {
		public function BasicSampleContext(contextView:IContextView, parentContext:IContext=null) {
			super(contextView, parentContext);
		}

		override protected function mapDependency():void {
			viewInjector.mapView(Dummy, DummyMediator);
			viewInjector.mapView(MessageInput, MessageInputMediator);
			viewInjector.mapView(MessageLog, MessageLogMediator);
			viewInjector.mapView(MessageLogListRenderer, MessageRendererMediator);

			injector.mapSingletonOf(MessageModel, LocalMessageModel);

			commandMap.mapCommand(MessageEvent.ADD_MESSAGE, AddMessage);
			commandMap.mapCommand(MessageEvent.REMOVE_MESSAGE, RemoveMessage);
		}

		override protected function shutdown():void {
			// TODO Auto Generated method stub
			super.shutdown();
		}

		override protected function startup():void {
			// TODO Auto Generated method stub
			super.startup();
		}

	}
}
