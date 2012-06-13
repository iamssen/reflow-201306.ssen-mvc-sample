package ssen.mvc.samples.basic {
	import ssen.mvc.core.IContext;
	import ssen.mvc.core.IContextView;
	import ssen.mvc.ondisplay.DisplayContext;
	import ssen.mvc.samples.basic.controller.AddMessage;
	import ssen.mvc.samples.basic.events.MessageUIEvent;
	import ssen.mvc.samples.basic.model.MessageModel;
	import ssen.mvc.samples.basic.model.MessageModelImplLocal;
	import ssen.mvc.samples.basic.view.Dummy;
	import ssen.mvc.samples.basic.view.DummyMediator;
	import ssen.mvc.samples.basic.view.MessageInput;
	import ssen.mvc.samples.basic.view.MessageInputMediator;

	public class BasicSampleContext extends DisplayContext {
		public function BasicSampleContext(contextView:IContextView, parentContext:IContext=null) {
			super(contextView, parentContext);
		}

		override protected function mapDependency():void {
			viewInjector.mapView(Dummy, DummyMediator);
			viewInjector.mapView(MessageInput, MessageInputMediator);

			injector.mapSingletonOf(MessageModel, MessageModelImplLocal);

			commandMap.mapCommand(MessageUIEvent.ADD_MESSAGE, AddMessage);
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
