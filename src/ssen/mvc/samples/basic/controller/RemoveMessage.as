package ssen.mvc.samples.basic.controller {
	import flash.events.Event;

	import ssen.mvc.core.ICommand;
	import ssen.mvc.core.IContextDispatcher;
	import ssen.mvc.samples.basic.events.MessageErrorEvent;
	import ssen.mvc.samples.basic.events.MessageEvent;
	import ssen.mvc.samples.basic.model.MessageModel;

	public class RemoveMessage implements ICommand {

		//=========================================================
		// 주입되는 의존성
		//=========================================================
		[Inject]
		public var model:MessageModel;

		[Inject]
		public var dispatcher:IContextDispatcher;

		//=========================================================
		// 실행
		//=========================================================
		public function execute(event:Event=null):void {
			
			//---------------------------------------
			// input event : command 실행에 사용된 event
			// output event : model 에 대한 실행이 성공적일때 알릴 event
			// error event : model 에 대한 실행이 실패했을때 알릴 event
			//---------------------------------------
			var inputEvt:MessageEvent=event as MessageEvent;
			var outputEvt:MessageEvent;
			var errorEvt:MessageErrorEvent;

			
			model.removeMessage(inputEvt.messageId, 
				
				function(id:int):void {
					outputEvt=new MessageEvent(MessageEvent.REMOVED_MESSAGE);
					outputEvt.messageId=id;
					dispatcher.dispatch(outputEvt);
				}, 
				
				function(error:Error):void {
					errorEvt=new MessageErrorEvent(MessageErrorEvent.REMOVE_FAILED, error.message,
												   error.errorID);
					dispatcher.dispatch(errorEvt);
				}
			);
		}
	}
}
