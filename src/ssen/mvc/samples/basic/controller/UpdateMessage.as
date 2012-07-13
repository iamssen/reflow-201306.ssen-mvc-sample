package ssen.mvc.samples.basic.controller {
	import flash.events.Event;

	import ssen.mvc.core.ICommand;
	import ssen.mvc.core.IEventBus;
	import ssen.mvc.samples.basic.events.MessageErrorEvent;
	import ssen.mvc.samples.basic.events.MessageEvent;
	import ssen.mvc.samples.basic.model.Message;
	import ssen.mvc.samples.basic.model.MessageModel;

	public class UpdateMessage implements ICommand {

		//=========================================================
		// 주입되는 의존성
		//=========================================================
		[Inject]
		public var model:MessageModel;

		[Inject]
		public var eventBus:IEventBus;

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

			model.updateMessage(inputEvt.messageId, inputEvt.text,

				function(message:Message):void {
					outputEvt=new MessageEvent(MessageEvent.UPDATED_MESSAGE);
					outputEvt.message=message;
					eventBus.dispatchEvent(outputEvt);
				},

				function(error:Error):void {
					errorEvt=new MessageErrorEvent(MessageErrorEvent.UPDATE_FAILED, error.message,
												   error.errorID);
					eventBus.dispatchEvent(errorEvt);
				});
		}
	}
}
