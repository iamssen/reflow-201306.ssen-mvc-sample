package ssen.mvc.samples.basic.controller {
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	import spark.components.TitleWindow;
	
	import ssen.mvc.core.ICommand;
	import ssen.mvc.core.IContextView;
	import ssen.mvc.core.IViewOpener;
	import ssen.mvc.samples.basic.events.MessageEvent;
	import ssen.mvc.samples.basic.view.MessageUpdate;
	import ssen.mvc.samples.basic.view.MessageUpdateSkin;

	//=========================================================
	// AddMessage, RemoveMessage, UpdateMessage 와는 틀리게
	// Data logic 이 아닌, View 의 흐름을 제어 하기 위한 Command 입니다
	//=========================================================
	public class StartUpdateMessage implements ICommand {
		[Inject]
		public var contextView:IContextView;

		[Inject]
		public var viewOpener:IViewOpener;

		public function execute(event:Event=null):void {
			var inputEvt:MessageEvent=event as MessageEvent;

			// view 를 생성
			var view:MessageUpdate=new MessageUpdate;
			view.setStyle("skinClass", MessageUpdateSkin);
			view.targetMessageId=inputEvt.messageId;

			// context view 의 child 가 아닌 popup 같은 경우를 처리하기 위한 view opener 입니다.
			// 기본적으로 ssen mvc framework 는 context view 이내의 added to stage 를 감지해서 view 와 mediator 를 제어하기 때문에
			// 이와 같은 예외 상황에서는 view opener 를 사용해야 합니다
			//
			// popup 같이 외부에서 제어되는 view 를 위해서만 사용해야 합니다
			viewOpener.ready(view);

			// view 가 window 의 close 를 컨트롤 할 수 있도록 전달해줍니다
			view.openWindow(new TitleWindow, contextView as DisplayObject);			
		}
	}
}
