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

		//=========================================================
		// 의존성을 선언하는 시점
		//=========================================================
		override protected function mapDependency():void {
			
			//---------------------------------------
			// View 와 Mediator 의 연계를 선언해줍니다
			//
			// Mediator 를 선언해주면
			// View 가 addChild 되는 시점에 Mediator 를 자동으로 생성, 실행 시켜줍니다
			//---------------------------------------
			viewInjector.mapView(Dummy, DummyMediator);
			viewInjector.mapView(MessageInput, MessageInputMediator);
			viewInjector.mapView(MessageLog, MessageLogMediator);
			viewInjector.mapView(MessageLogListRenderer, MessageRendererMediator);

			//---------------------------------------
			// Model 과 같이 사용할 의존성을 선언해줍니다
			//---------------------------------------
			injector.mapSingletonOf(MessageModel, LocalMessageModel);

			//---------------------------------------
			// Command 를 선언해줍니다
			//
			// 선언해주면 Event 가 dispatch 되는 순간
			// Command 를 자동으로 생성, 실행 시켜줍니다
			//---------------------------------------
			commandMap.mapCommand(MessageEvent.ADD_MESSAGE, AddMessage);
			commandMap.mapCommand(MessageEvent.REMOVE_MESSAGE, RemoveMessage);
		}

		//=========================================================
		// context view 가 실행, 종료되는 시점 (기본적으로 addedToStage, removedFromStage)
		// 에 실행되는 기능들
		//=========================================================		
		override protected function startup():void {
			// TODO Auto Generated method stub
			super.startup();
		}
		
		override protected function shutdown():void {
			// TODO Auto Generated method stub
			super.shutdown();
		}

	}
}
